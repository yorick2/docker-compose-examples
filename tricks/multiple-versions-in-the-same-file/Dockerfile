FROM alpine:latest as base

RUN echo -e "\e[32m ##### base container ##### \e[39m"

FROM base as prod

RUN echo -e "\e[32m ##### prod container ##### \e[39m"

FROM base as stage

RUN echo -e "\e[32m ##### stage container ##### \e[39m"

FROM prod as dev

RUN echo -e "\e[32m ##### dev container ##### \e[39m"

