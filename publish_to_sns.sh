#/bin/bash

topicARN=arn:aws:sns:eu-central-1:610643098352:munin-test-1
json=`cat test.json`
aws="/Users/bandersen/Library/Python/2.7/bin/aws"
region=eu-central-1

${aws} sns publish --topic-arn $topicARN --message-structure json --message "${json}" --region ${region}
