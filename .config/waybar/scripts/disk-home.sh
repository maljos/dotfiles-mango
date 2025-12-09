#!/bin/bash
df -h /home | awk 'NR==2 {printf "{\"text\":\"%s\",\"class\":\"\"}", $4}'
