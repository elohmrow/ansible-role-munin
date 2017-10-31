from __future__ import print_function
import sys

import smtplib
import email.message
import email.utils

if (len(sys.argv) < 4):  
    usage = """\n==================================================================================
    You need to tell me:
	    - the email address of the alert contact 
	    - the hostname or ip address of the machine having problems 
	    - the name of the service having problems 
    Something like this:
            {0} bradley.andersen@magnolia-cms.com 192.168.0.4 disk_usage
==================================================================================\n"""

    print(usage.format(sys.argv[0]))
    sys.exit(0)

email_from = "bradley.andersen@magnolia-cms.com"
email_body = "Host: [{0}] Service: [{1}] is down."

email_to = sys.argv[1]
host = sys.argv[2]
service_name = sys.argv[3]

def send_email(email_to, host, service_name):
    msg = email.message.Message()
    msg['From'] = email_from
    msg['To'] = email_to
    msg['Subject'] = service_name
    msg.add_header('Content-Type', 'text')
    msg.set_payload(email_body.format(host, service_name))

    smtp_obj = smtplib.SMTP("magnolia-cms.com")
    smtp_obj.sendmail(msg['From'], [msg['To']], msg.as_string())
    smtp_obj.quit()

send_email(email_from, host, service_name)
