#include <ruby.h>
#include <stdio.h>

VALUE read_next()
{
  VALUE c = rb_const_get(rb_cObject, rb_intern("Reindeer"));
  char name[20] = {0};
  int speed;
  int time;
  int rest;

  if(scanf("%s can fly %d km/s for %d seconds, but then must rest for %d seconds.\n", name, &speed, &time, &rest) == -1)
    return Qnil;

  return rb_funcall(c, rb_intern("new"), 4, rb_str_new_cstr(name), INT2FIX(speed), INT2FIX(time), INT2FIX(rest));
}

int max_by(VALUE* reindeer, int n, const char* by)
{
  int max = 0;
  for(int i = 0; i < n; ++i)
  {
    VALUE v = rb_funcall(reindeer[i], rb_intern(by), 0);
    if(FIX2INT(v) > max)
      max = FIX2INT(v);
  }
  return max;
}

int max_distance(VALUE* reindeer, int n, int time)
{
  for(int i = 0; i < n; ++i)
    rb_funcall(reindeer[i], rb_intern("fly!"), 1, INT2FIX(time));

  return max_by(reindeer, n, "distance");
}

int max_score(VALUE* reindeer, int n, int time)
{
  for(int t = 1; t <= time; ++t)
  {
    int d = max_distance(reindeer, n, t);
    for(int i = 0; i < n; ++i)
    {
      VALUE v = rb_funcall(reindeer[i], rb_intern("distance"), 0);
      if(FIX2INT(v) == d)
        rb_funcall(reindeer[i], rb_intern("leading!"), 0);
    }
  }

  return max_by(reindeer, n, "score");
}

int main(int argc, const char* argv[])
{
  const char* part = getenv("PART");

  VALUE* reindeer = NULL;
  int n = 0;

  ruby_init();

  rb_require("./reindeer");

  for(VALUE v; (v = read_next()) != Qnil;)
  {
    reindeer = realloc(reindeer, ++n*sizeof(VALUE));
    reindeer[n-1] = v;
  }

  if(part && *part == '1')
    printf("%d\n", max_distance(reindeer, n, atoi(argv[1])));
  else
    printf("%d\n", max_score(reindeer, n, atoi(argv[1])));

  free(reindeer);
  return ruby_cleanup(0);
}
