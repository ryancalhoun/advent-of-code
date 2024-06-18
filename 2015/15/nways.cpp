#include <mex.h>
#include <functional>

namespace
{
  int choose(int n, int k) {
    if(k == 0)
      return 1;
    return (n * choose(n-1, k-1)) / k;
  }

  void nways(int n, int k, int d[], std::function<void(int[])> f) {
    if(k == 1) {
      d[0] = n;
      f(d);
    } else {
      for(int i = 1; i < n - (k-1) + 1; ++i) {
        d[k-1] = i;
        nways(n-i, k-1, d, f);
      }
    }
  }

  void nways(int n, int k, std::function<void(int[])> f) {
    int d[k];
    nways(n, k, d, f);
  }
}

extern "C" {
  void mexFunction(int nOut, mxArray** out, int nIn, const mxArray** in) {

    if(nIn != 2) {
      mexErrMsgIdAndTxt("In:Arg", "Function requires arguments (n,k)");
    }
    if(nOut > 1) {
      mexErrMsgIdAndTxt("In:Out", "Function returns a single result");
    }

    int n = *(mxGetPr(in[0]));
    int k = *(mxGetPr(in[1]));

    if(k >= n) {
      mexErrMsgIdAndTxt("In:Arg", "Function arguments must be n > k");
    }

    int rows = choose(n-1, k-1);

    *out = mxCreateDoubleMatrix(rows, k, mxREAL);

    mxDouble* w = mxGetPr(*out);
    nways(n, k, [&w,k,rows](int d[]) {
      for(int i = 0; i < k; ++i) {
        w[i*rows] = d[i];
      }
      w += 1;
    });
  }
}
