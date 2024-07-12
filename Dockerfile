FROM redis:7-alpine

ARG REDIS_PASSWORD=''

COPY ./redis.conf /usr/local/etc/redis/redis.conf
# Replace password with given one.
RUN echo $REDIS_PASSWORD
RUN if [[ -n "$REDIS_PASSWORD" ]] ; \
    then sed -i "s/^#\(requirepass\) \w\+/\1 $REDIS_PASSWORD/" /usr/local/etc/redis/redis.conf ; \
    fi

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

EXPOSE 6379
