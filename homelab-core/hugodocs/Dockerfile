FROM ghcr.io/gohugoio/hugo:latest

RUN mkdir -p /project/themes/hugo-geekdoc/
ADD --chmod=777 https://github.com/thegeeklab/hugo-geekdoc/releases/latest/download/hugo-geekdoc.tar.gz /project/themes/
RUN tar -xzf /project/themes/hugo-geekdoc.tar.gz -C /project/themes/hugo-geekdoc --strip-components=1 && \
    rm /project/themes/hugo-geekdoc.tar.gz
