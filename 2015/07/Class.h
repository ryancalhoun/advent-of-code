#pragma once

#include <string>
#include <memory>
#include <jni.h>

class Instance;

class Class
{
public:
  Class(JNIEnv* env, jclass cls);

  std::shared_ptr<Instance> createInstance();

protected:
  JNIEnv* _env;
  jclass _cls;
  jmethodID _constructor;
};

