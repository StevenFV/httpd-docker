FROM axllent/mailpit:v1.21.8

EXPOSE 1025 8025

CMD ["--listen", "0.0.0.0:8025", "--smtp", "0.0.0.0:1025"]