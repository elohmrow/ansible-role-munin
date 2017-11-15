#/bin/bash

# you can't run this without setting up your ".aws/credentials" ... could ansibilize that too, but ...

topicARN=arn:aws:sns:eu-central-1:610643098352:munin-test-1
json=`cat /etc/munin/test.json`
aws="/Users/bandersen/Library/Python/2.7/bin/aws" # where is your aws cli?
region=eu-central-1

${aws} sns publish --topic-arn $topicARN --message-structure json --message "${json}" --region ${region}
