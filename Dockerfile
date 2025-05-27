FROM openjdk:latest
RUN microdnf update
RUN microdnf install yum
ENV SCALA_VERSION=2.13.6
ENV SCALA_HOME=/usr/local/share/scala
RUN curl -fL "https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz" | tar xfz - -C /usr/local/share \
    && mv "/usr/local/share/scala-$SCALA_VERSION" "$SCALA_HOME" \
    && ln -s "$SCALA_HOME/bin/"* /usr/local/bin/
ENV SPARK_HOME=/usr/local/share/spark
RUN SPARK_VERSION=$(curl -s https://downloads.apache.org/spark/ | grep -o 'spark-[0-9.]\+/' | sed 's#/##' | sort -V | tail -n 1) && \
    echo "https://downloads.apache.org/spark/$SPARK_VERSION/$SPARK_VERSION-bin-hadoop3.tgz" && \
    curl -fL "https://downloads.apache.org/spark/$SPARK_VERSION/$SPARK_VERSION-bin-hadoop3.tgz" | tar xfz - -C /usr/local/share && \
    mv "/usr/local/share/$SPARK_VERSION-bin-hadoop3" "$SPARK_HOME"
ENV PATH="$PATH:$SPARK_HOME/bin"
RUN rm -f /etc/yum.repos.d/bintray-rpm.repo && \
    curl -L https://www.scala-sbt.org/sbt-rpm.repo > sbt-rpm.repo && \
    mv sbt-rpm.repo /etc/yum.repos.d/ && \
    yum install sbt -y
CMD ["tail", "-f", "/dev/null"]
