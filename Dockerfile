FROM scratch
EXPOSE 8080
ENTRYPOINT ["/test1"]
COPY ./bin/ /