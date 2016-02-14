#wordcount.clj#  wordcount.clj  wordcount.clj~
[root@ip-10-7-189-14 topologies]# cat wordcount.clj
(ns tweetcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetcount [options]
   [
    ;; spout configuration
    {"tweet-spout" (python-spout-spec
          options
          "spouts.sentences.Sentences"
          ["sentence"]
          )
    }
    ;; bolt configuration 1
    {"parse-bolt" (python-bolt-spec
          options
          {"tweet-spout" :shuffle}
          "bolts.parse.ParseTweet"
          ["valid_words"]
          :p 2
          )

    ;; bolt configuration 2
    "count-bolt" (python-bolt-spec
          options
          {"parse-bolt" :shuffle}
          "bolts.tweetcounter.TweetCounter"
          ["word" "count"]
          :p 2
          )
    }
  ]
)
