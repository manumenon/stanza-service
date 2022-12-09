FROM ubuntu:latest
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update -y && \
        apt-get install -y apt-utils \
                default-jre \
                default-jdk \
                ant \
                unzip \
                wget \
                git && rm -rf /var/lib/apt/lists/*

RUN export VERSION="4.4.0"; \
        wget https://downloads.cs.stanford.edu/nlp/software/stanford-corenlp-${VERSION}.zip; \
        unzip stanford-corenlp-${VERSION}.zip; \
        ls -l ; \
        mv stanford-corenlp-${VERSION} CoreNLP; \
        rm -rf stanford-corenlp-${VERSION}.zip; \
        cd CoreNLP; \
        export CLASSPATH=""; for file in `find . -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done



#RUN export REL_DATE="2018-10-05"; \
#       wget http://nlp.stanford.edu/software/stanford-corenlp-full-${REL_DATE}.zip; \
#       unzip stanford-corenlp-full-${REL_DATE}.zip; \
#       mv stanford-corenlp-full-${REL_DATE} CoreNLP; \
#        rm -rf stanford-corenlp-full-${REL_DATE}.zip; \
#       cd CoreNLP; \
#       export CLASSPATH=""; for file in `find . -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done

ENV PORT 80

EXPOSE 80

WORKDIR CoreNLP

RUN rm -rf /var/lib/apt/lists/*
CMD java -cp '*' -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer -timeout 60000 -maxCharLength 100000 -annotators tokenize,ssplit,pos,lemma,ner -preload -username admin -password admin1234 -port 80
