<?php
ini_set('memory_limit', -1);
$scale = array('limit' => 300*1000, 'offset' => rand(0,1500*1000));

$benchmarks = array(
  'select 1' => function($mysqli, $redis) {
    $res = $mysqli->query("SELECT 1");
    $res->close();
  },
  'select full count' => function($mysqli, $redis) {
    $res = $mysqli->query("SELECT count(*) FROM civicrm_contact");
    $res->close();
  },
  'select id, display_name' => function($mysqli, $redis) use ($scale) {
    $rows = array();
    $result = $mysqli->query("SELECT id, display_name FROM civicrm_contact LIMIT {$scale['limit']} OFFSET {$scale['offset']}");
    while ($row = $result->fetch_row()) { $rows[] = $row; }
    $result->close();
    if (count($rows) !== $scale['limit']) throw new \Exception("Unexpected count: " . count($rows));
  },
  'fill redis w/ids+names (serialize())' => function($mysqli, $redis) use ($scale) {
    $rows = array();
    $result = $mysqli->query("SELECT id, display_name FROM civicrm_contact LIMIT {$scale['limit']} OFFSET {$scale['offset']}");
    while ($row = $result->fetch_row()) { $rows[] = $row; }
    $result->close();
    $redis->set('myquerycache', serialize($rows));
  },
  'fill redis w/ids+names (json_encode())' => function($mysqli, $redis) use ($scale) {
    $rows = array();
    $result = $mysqli->query("SELECT id, display_name FROM civicrm_contact LIMIT {$scale['limit']} OFFSET {$scale['offset']}");
    while ($row = $result->fetch_row()) { $rows[] = $row; }
    $result->close();
    $redis->set('myquerycache', json_encode($rows));
  },
  'fill prevnext cache w/ids' => function($mysqli, $redis) use ($scale) {
    $cacheKey = md5(rand() . rand());
    $result = $mysqli->query("INSERT INTO civicrm_prevnext_cache (entity_table, entity_id1, entity_id2, cacheKey, data) SELECT 'civicrm_contact', id, id, '$cacheKey', NULL FROM civicrm_contact LIMIT {$scale['limit']} OFFSET {$scale['offset']}");
  },
  'create temp ids+names' => function($mysqli, $redis) use ($scale) {
    $result = $mysqli->query("CREATE TEMPORARY TABLE foo SELECT id, display_name FROM civicrm_contact LIMIT {$scale['limit']} OFFSET {$scale['offset']}");
    $result = $mysqli->query("DROP TEMPORARY TABLE foo");
  },
);

printf("Connect to %s\n", getenv('AMP_DB_NAME'));
$mysqli = new mysqli(getenv('AMP_DB_HOST'), getenv('AMP_DB_USER'), getenv('AMP_DB_PASS'), getenv('AMP_DB_NAME'), getenv('AMP_DB_PORT'));
if ($mysqli->connect_errno) {
    throw new \Exception("Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error);
}

$redis = new Redis();
$redis->pconnect('127.0.0.1', 7777);

print_r(['Scale' => $scale]);
$stats = array();
for ($trial = 0; $trial < 5; $trial++) {
  foreach ($benchmarks as $name => $callback) {
    $start = microtime(1);
    call_user_func($callback, $mysqli, $redis);
    $end = microtime(1);
    $stats[$name][$trial] = $end-$start;
    printf("Trial #%02d: %-30s ==> %.3f\n", $trial, $name, $stats[$name][$trial]);

    // General cleanup
    $mysqli->query('TRUNCATE civicrm_prevnext_cache');
  }
}

echo "\n\n";
foreach ($stats as $name => $result) {
  printf("Average: %-30s ==> %.3f\n", $name, array_sum($result) / count($result));
}
