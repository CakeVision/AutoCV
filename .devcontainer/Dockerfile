# Dockerfile
FROM eclipse-temurin:21-jdk

# Install essential development tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Gradle (latest stable)
ENV GRADLE_VERSION=8.10
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp \
    && unzip /tmp/gradle-${GRADLE_VERSION}-bin.zip -d /opt \
    && rm /tmp/gradle-${GRADLE_VERSION}-bin.zip \
    && ln -s /opt/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/gradle

# Install Kotlin compiler (optional, since Gradle handles it, but useful for REPL)
ENV KOTLIN_VERSION=2.0.10
RUN wget https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip -P /tmp \
    && unzip /tmp/kotlin-compiler-${KOTLIN_VERSION}.zip -d /opt \
    && rm /tmp/kotlin-compiler-${KOTLIN_VERSION}.zip \
    && ln -s /opt/kotlinc/bin/kotlin /usr/local/bin/kotlin \
    && ln -s /opt/kotlinc/bin/kotlinc /usr/local/bin/kotlinc

# Create a non-root user for development
RUN useradd -m -s /bin/bash developer
USER developer
WORKDIR /home/developer

# Set up Gradle user home for caching dependencies
ENV GRADLE_USER_HOME=/home/developer/.gradle

# Keep container running for development
CMD ["tail", "-f", "/dev/null"]
