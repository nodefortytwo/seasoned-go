# seasoned-go
 Go image with libsodium installed... so its... Go with... salt... get it?
 
 ##Example Drone 
 ```yaml
 build:
     image: nodefortytwo/seasoned-go:latest
     commands:
       - mkdir lib
       - cp /usr/local/lib/libsodium.so.23.2.0 lib/
       - cp /usr/local/lib/libsodium.so.23 lib/
       - cp /usr/local/lib/libsodium.so lib/
       - go build -o ${DRONE_REPO_NAME}
     volumes:
       - /efs-share/go_mod/${DRONE_REPO}:/go/pkg/mod
     when: *on-push-master

 package-artifact:
     image: kramos/alpine-zip
     commands: zip -j code.zip ${DRONE_REPO_NAME} lib/*
     when: *on-push-master
```
