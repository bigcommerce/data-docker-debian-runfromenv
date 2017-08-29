FROM debian:jessie
COPY run-from-env.sh /bin/run-from-env.sh
CMD ["/bin/run-from-env.sh"]
