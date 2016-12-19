rm -f "${SXHKD_FIFO}" && mkfifo "${SXHKD_FIFO}" && \
    nexec sxhkd && sxhkd -s "${SXHKD_FIFO}" > /dev/null &
