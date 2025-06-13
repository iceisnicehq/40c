#!/bin/bash  

LOG_FILE="/root/logssamba"  
for i in {1..200}; do  
    USERNAME="userau$i"  

    # Проверка существования пользователя  
    if samba-tool user show "$USERNAME" &> /dev/null; then  
        echo "Пользователь $USERNAME уже существует" >> "$LOG_FILE"  
    else  
        if samba-tool user create "$USERNAME" "P@ssw0rd" &>> "$LOG_FILE"; then  
            echo "Пользователь $USERNAME успешно создан" >> "$LOG_FILE"  
        else  
            echo "Ошибка при создании пользователя $USERNAME" >> "$LOG_FILE" 
        fi  
    fi 
done  
