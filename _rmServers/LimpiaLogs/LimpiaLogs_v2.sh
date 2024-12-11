tar czf - /var/log/ | ssh rmonla@10.0.10.17 "cat > /home/rmonla/bkp/bkplogs_srv-proxy-intra-A.tar.gz"

NOM_DIR="bkplogs_$(hostname)_$(date +'%Y%m%d_%H%M')" && tar cf - /var/log | pv -cN tar_progress | ssh rmonla@10.0.10.17 "cat > /home/rmonla/bkp/bkplogs_srv-proxy-intra_$(date +'%Y%m%d_%H%M').tar" && for file in $(find /var/log -type f -size +1G); do echo '' > "$file"; done


tar cf - /var/log | ssh rmonla@10.0.10.17 "cat > /home/rmonla/bkp/bkplogs_srv-proxy-intra_$(date +'%Y%m%d_%H%M').tar" && for file in $(find /var/log -type f -size +1G); do echo '' > "$file"; done