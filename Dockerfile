FROM ansible/ansible-runner

RUN pip3 install "ansible-lint[yamllint]"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
