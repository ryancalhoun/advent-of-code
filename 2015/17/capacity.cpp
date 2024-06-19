#include <node.h>
#include <string>
#include <list>
#include <functional>

class Containers
{
public:
  Containers(std::function<void (const std::list<size_t>&)> f);

  void add(size_t c);
  void ways(size_t target) const;

protected:
  void ways(size_t target, std::list<size_t>::const_iterator s, std::list<size_t>& c) const;

protected:
  std::list<size_t> _containers;
  std::function<void (const std::list<size_t>&)> _f;
};

Containers::Containers(std::function<void (const std::list<size_t>&)> f)
  : _f(f)
{}

void Containers::add(size_t c)
{
  _containers.push_back(c);
}

void Containers::ways(size_t target) const
{
  std::list<size_t> c;
  ways(target, _containers.begin(), c);
}

void Containers::ways(size_t target, std::list<size_t>::const_iterator s, std::list<size_t>& c) const
{
  if(target == 0)
    return _f(c);

  for(auto it = s; it != _containers.end(); ++it)
  {
    if(*it > target)
      continue;

    c.push_back(*it);
    ways(target - *it, std::next(it), c);
    c.pop_back();
  }
}

template <typename T>
void ignore(const T&) { }

void Method(const v8::FunctionCallbackInfo<v8::Value>& args)
{
  auto* is = args.GetIsolate();
  auto ctx = v8::Context::New(is);

  size_t target = args[0]->Int32Value(ctx).FromJust();
  auto containers = v8::Local<v8::Array>::Cast(args[1]);
  auto f = v8::Handle<v8::Function>::Cast(args[2]);

  Containers c([&f,&ctx,is] (const std::list<size_t>& way) {
    auto to_i = [is,&ctx](int i) { return v8::Local<v8::Value>::Cast(v8::Number::New(is, i)); };

    auto a = v8::Array::New(is, way.size());
    size_t i = 0;

    for(auto w : way)
      ignore(a->Set(ctx, to_i(i++), to_i(w)));

    auto v = v8::Local<v8::Value>::Cast(a);
    ignore(f->Call(ctx, ctx->Global(), 1, &v));
  });

  for(size_t i = 0; i < containers->Length(); ++i)
    c.add(containers->Get(ctx, i).ToLocalChecked()->Int32Value(ctx).FromJust());

  c.ways(target);
}

void Initialize(v8::Local<v8::Object> exports, v8::Local<v8::Value>, void*)
{
  NODE_SET_METHOD(exports, "ways", Method);
}

NODE_MODULE(NODE_GYP_MODULE_NAME, Initialize)

