#!/usr/bin/env bash

echo "========================================"
echo "   ESTATÍSTICAS DO SERVIDOR - $(date)"
echo "========================================"

# 1. CPU - Calculando o uso (100 - idle)
echo "--- CPU ---"
top -bn1 | grep "Cpu(s)" | awk '{print "Uso Total: " 100 - $8 "%"}'

# 2. Memória - Total, Usada e %
echo -e "\n--- MEMÓRIA ---"
free -m | awk '/Mem:/ { printf "Usada: %dMB / Total: %dMB (%.2f%%)\n", $3, $2, ($3/$2)*100 }'

# 3. Disco - Total, Usado e %
echo -e "\n--- DISCO ---"
df / --output=size,used,avail,pcent | tail -1 | awk '{ print "Usado: " $2 " / Total: " $1 " (" $4 ")" }'

# 4. Top 5 Processos por CPU
echo -e "\n--- TOP 5 PROCESSOS (CPU) ---"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | awk '
  BEGIN { printf "%-10s %-20s %-10s\n", "PID", "COMANDO", "%CPU" }
  NR>1 { printf "%-10s %-20s %-10s\n", $1, $2, $3 }'

# 5. Top 5 Processos por Memória
echo -e "\n--- TOP 5 PROCESSOS (MEMÓRIA) ---"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 | awk '
  BEGIN { printf "%-10s %-20s %-10s\n", "PID", "COMANDO", "%MEM" }
  NR>1 { printf "%-10s %-20s %-10s\n", $1, $2, $3 }'

echo "========================================"