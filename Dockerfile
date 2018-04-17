FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK="27"
ENV ANDROID_BUILD_TOOLS="27.0.3"
ENV ANDROID_SDK_TOOLS="24.4.1"

ENV	PATH="${PATH}:${PWD}/android-sdk-linux/platform-tools/"
ENV	ANDROID_HOME="${PWD}/android-sdk-linux"
 
RUN apt-get --quiet update --yes  && \
   apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 && \
   wget --quiet --output-document=android-sdk.tgz https://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz && \
   tar --extract --gzip --file=android-sdk.tgz && \
   echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter android-${ANDROID_COMPILE_SDK} && \
   echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter platform-tools && \
   echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter build-tools-${ANDROID_BUILD_TOOLS} && \
   echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-android-m2repository && \
   echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-google_play_services && \
   echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter extra-google-m2repository && \
   echo y | android-sdk-linux/tools/android --silent update sdk --no-ui --all --filter sys-img-x86-google_apis-${ANDROID_COMPILE_SDK} && \
   echo no | android-sdk-linux/tools/android create avd -n test -t android-${ANDROID_COMPILE_SDK} --abi google_apis/x86  && \
   mkdir -p "$ANDROID_HOME/licenses"  && \
   echo -e "\nd56f5187479451eabf01fb78af6dfcb131a6481e" > "$ANDROID_HOME/licenses/android-sdk-license"
