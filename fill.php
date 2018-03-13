<?php

$firsts = ['Alice', 'Bob', 'Carol', 'Dave'];
$lasts = ['Albertson', 'Bobbit', 'Carolina', 'Davinsky', 'Evesky', 'Eff', 'Gee', 'Aych'];


printf("INSERT INTO civicrm_contact(first_name, last_name, display_name) VALUES");
for ($i = $argv[1] ; $i < $argv[2]; $i++) {
  $first = $firsts[$i % count($firsts)];
  $last = $lasts[$i % count($lasts)] . "-$i";
  $tail = ($i == $argv[2]-1) ? ';' : ',';
  printf(" ('%s', '%s', '%s') %s\n", $first, $last, "$first $last", $tail);
}
