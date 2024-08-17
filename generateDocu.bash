#!/bin/bash
docker run --rm -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor ReadMe.adoc
