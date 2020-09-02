FROM debian:buster
COPY ./srcs
RUN builds your application with make.
CMD specifies what command to run within the container.