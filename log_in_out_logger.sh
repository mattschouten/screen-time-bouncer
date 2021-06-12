#!/bin/bash 

echo "[$(date)] User: $PAM_USER performed operation $PAM_TYPE" >> /home/matt/kiddo_logs/login_out.txt
