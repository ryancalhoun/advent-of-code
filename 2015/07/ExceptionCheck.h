#pragma once

#include<jni.h>

class ExceptionCheck
{
public:
  ExceptionCheck(JNIEnv* env);
  ~ExceptionCheck() noexcept(false);

protected:
  JNIEnv* _env;
};
