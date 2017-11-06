#!/bin/bash
 
aws="/Users/bandersen/Library/Python/2.7/bin/aws"
region=eu-central-1

${aws} lambda invoke \
--invocation-type RequestResponse \
--function-name munin-test-1 \
--region ${region} \
--log-type Tail \
--payload '{"key1":"value1", "key2":"value2", "key3":"value3"}' \
outputfile.txt 
