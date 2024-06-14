#include "StringArray.h"

StringArray::StringArray(JNIEnv* env, const std::vector<std::string>& arr)
  : _env(env)
  , _jarr(env->NewObjectArray(arr.size(), env->FindClass("java/lang/String"), NULL))
{
  if(! _jarr)
    throw "array";

  for(int i = 0; i < arr.size(); ++i)
  {
    _arr.emplace_back(env, arr[i]);
    _env->SetObjectArrayElement(_jarr, i, *_arr.back());
  }
}

StringArray::~StringArray()
{
  _env->DeleteLocalRef(_jarr);
}

jobjectArray StringArray::operator*()
{
  return _jarr;
}
