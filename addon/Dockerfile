ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add nodejs npm
RUN npm i -g tsx nodemon

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
