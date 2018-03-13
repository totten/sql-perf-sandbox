#!/bin/bash

eval $( amp export )

export AMP_ROOT AMP_DB_DSN AMP_DB_USER AMP_DB_PASS AMP_DB_HOST AMP_DB_PORT AMP_DB_NAME

php benchmark.php
