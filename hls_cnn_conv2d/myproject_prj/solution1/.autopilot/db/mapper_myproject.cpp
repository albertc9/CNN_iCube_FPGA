#include "hls_signal_handler.h"
#include <algorithm>
#include <cassert>
#include <fstream>
#include <iostream>
#include <list>
#include <map>
#include <vector>
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"
using namespace std;

namespace hls::sim
{
  template<size_t n>
  struct Byte {
    unsigned char a[n];

    Byte()
    {
      for (size_t i = 0; i < n; ++i) {
        a[i] = 0;
      }
    }

    template<typename T>
    Byte<n>& operator= (const T &val)
    {
      std::memcpy(a, &val, n);
      return *this;
    }
  };

  struct SimException : public std::exception {
    const std::string msg;
    const size_t line;
    SimException(const std::string &msg, const size_t line)
      : msg(msg), line(line)
    {
    }
  };

  void errExit(const size_t line, const std::string &msg)
  {
    std::string s;
    s += "ERROR";
//  s += '(';
//  s += __FILE__;
//  s += ":";
//  s += std::to_string(line);
//  s += ')';
    s += ": ";
    s += msg;
    s += "\n";
    fputs(s.c_str(), stderr);
    exit(1);
  }
}


namespace hls::sim
{
  struct Buffer {
    char *first;
    Buffer(char *addr) : first(addr)
    {
    }
  };

  struct DBuffer : public Buffer {
    static const size_t total = 1<<10;
    size_t ufree;

    DBuffer(size_t usize) : Buffer(nullptr), ufree(total)
    {
      first = new char[usize*ufree];
    }

    ~DBuffer()
    {
      delete[] first;
    }
  };

  struct CStream {
    char *front;
    char *back;
    size_t num;
    size_t usize;
    std::list<Buffer*> bufs;
    bool dynamic;

    CStream() : front(nullptr), back(nullptr),
                num(0), usize(0), dynamic(true)
    {
    }

    ~CStream()
    {
      for (Buffer *p : bufs) {
        delete p;
      }
    }

    template<typename T>
    T* data()
    {
      return (T*)front;
    }

    template<typename T>
    void transfer(hls::stream<T> *param)
    {
      while (!empty()) {
        param->write(*(T*)nextRead());
      }
    }

    bool empty();
    char* nextRead();
    char* nextWrite();
  };

  bool CStream::empty()
  {
    return num == 0;
  }

  char* CStream::nextRead()
  {
    assert(num > 0);
    char *res = front;
    front += usize;
    if (dynamic) {
      if (++static_cast<DBuffer*>(bufs.front())->ufree == DBuffer::total) {
        if (bufs.size() > 1) {
          bufs.pop_front();
          front = bufs.front()->first;
        } else {
          front = back = bufs.front()->first;
        }
      }
    }
    --num;
    return res;
  }

  char* CStream::nextWrite()
  {
    if (dynamic) {
      if (static_cast<DBuffer*>(bufs.back())->ufree == 0) {
        bufs.push_back(new DBuffer(usize));
        back = bufs.back()->first;
      }
      --static_cast<DBuffer*>(bufs.back())->ufree;
    }
    char *res = back;
    back += usize;
    ++num;
    return res;
  }

  std::list<CStream> streams;
  std::map<char*, CStream*> prebuilt;

  CStream* createStream(size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = true;
      s.bufs.push_back(new DBuffer(usize));
      s.front = s.bufs.back()->first;
      s.back = s.front;
      s.num = 0;
      s.usize = usize;
    }
    return &s;
  }

  template<typename T>
  CStream* createStream(hls::stream<T> *param)
  {
    CStream *s = createStream(sizeof(T));
    {
      s->dynamic = true;
      while (!param->empty()) {
        T data = param->read();
        memcpy(s->nextWrite(), (char*)&data, sizeof(T));
      }
      prebuilt[s->front] = s;
    }
    return s;
  }

  template<typename T>
  CStream* createStream(T *param, size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = false;
      s.bufs.push_back(new Buffer((char*)param));
      s.front = s.back = s.bufs.back()->first;
      s.usize = usize;
      s.num = ~0UL;
    }
    prebuilt[s.front] = &s;
    return &s;
  }

  CStream* findStream(char *buf)
  {
    return prebuilt.at(buf);
  }
}
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
unsigned int ap_apatb_input_1_cap_bc;
static AESL_RUNTIME_BC __xlx_input_1_V_size_Reader("../tv/stream_size/stream_size_in_input_1.dat");
unsigned int ap_apatb_layer8_out_cap_bc;
static AESL_RUNTIME_BC __xlx_layer8_out_V_size_Reader("../tv/stream_size/stream_size_out_layer8_out.dat");
using hls::sim::Byte;
struct __cosim_s2__ { char data[2]; };
extern "C" void myproject(__cosim_s2__*, __cosim_s2__*, Byte<2>*, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, Byte<2>*, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, volatile void *, Byte<2>*);
extern "C" void apatb_myproject_hw(volatile void * __xlx_apatb_param_input_1, volatile void * __xlx_apatb_param_layer8_out, volatile void * __xlx_apatb_param_w2, volatile void * __xlx_apatb_param_b2_0, volatile void * __xlx_apatb_param_b2_1, volatile void * __xlx_apatb_param_b2_2, volatile void * __xlx_apatb_param_b2_3, volatile void * __xlx_apatb_param_b2_4, volatile void * __xlx_apatb_param_b2_5, volatile void * __xlx_apatb_param_b2_6, volatile void * __xlx_apatb_param_b2_7, volatile void * __xlx_apatb_param_b2_8, volatile void * __xlx_apatb_param_b2_9, volatile void * __xlx_apatb_param_b2_10, volatile void * __xlx_apatb_param_b2_11, volatile void * __xlx_apatb_param_b2_12, volatile void * __xlx_apatb_param_b2_13, volatile void * __xlx_apatb_param_b2_14, volatile void * __xlx_apatb_param_b2_15, volatile void * __xlx_apatb_param_b2_16, volatile void * __xlx_apatb_param_b2_17, volatile void * __xlx_apatb_param_b2_18, volatile void * __xlx_apatb_param_b2_19, volatile void * __xlx_apatb_param_w4, volatile void * __xlx_apatb_param_b4_0, volatile void * __xlx_apatb_param_b4_1, volatile void * __xlx_apatb_param_b4_2, volatile void * __xlx_apatb_param_b4_3, volatile void * __xlx_apatb_param_b4_4, volatile void * __xlx_apatb_param_b4_5, volatile void * __xlx_apatb_param_b4_6, volatile void * __xlx_apatb_param_b4_7, volatile void * __xlx_apatb_param_b4_8, volatile void * __xlx_apatb_param_b4_9, volatile void * __xlx_apatb_param_w7) {
using hls::sim::createStream;
auto* sinput_1 = createStream((hls::stream<__cosim_s2__>*)__xlx_apatb_param_input_1);
  //Create input buffer for layer8_out
  ap_apatb_layer8_out_cap_bc = __xlx_layer8_out_V_size_Reader.read_size();
  __cosim_s2__* __xlx_layer8_out_input_buffer= new __cosim_s2__[ap_apatb_layer8_out_cap_bc];
auto* slayer8_out = createStream((hls::stream<__cosim_s2__>*)__xlx_apatb_param_layer8_out);
  // Collect __xlx_w2__tmp_vec
std::vector<Byte<2>> __xlx_w2__tmp_vec;
for (size_t i = 0; i < 800; ++i){
__xlx_w2__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_w2)[i]);
}
  int __xlx_size_param_w2 = 800;
  int __xlx_offset_param_w2 = 0;
  int __xlx_offset_byte_param_w2 = 0*2;
  // Collect __xlx_w4__tmp_vec
std::vector<Byte<2>> __xlx_w4__tmp_vec;
for (size_t i = 0; i < 2000; ++i){
__xlx_w4__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_w4)[i]);
}
  int __xlx_size_param_w4 = 2000;
  int __xlx_offset_param_w4 = 0;
  int __xlx_offset_byte_param_w4 = 0*2;
  // Collect __xlx_w7__tmp_vec
std::vector<Byte<2>> __xlx_w7__tmp_vec;
for (size_t i = 0; i < 2380; ++i){
__xlx_w7__tmp_vec.push_back(((Byte<2>*)__xlx_apatb_param_w7)[i]);
}
  int __xlx_size_param_w7 = 2380;
  int __xlx_offset_param_w7 = 0;
  int __xlx_offset_byte_param_w7 = 0*2;
  // DUT call
  myproject(sinput_1->data<__cosim_s2__>(), slayer8_out->data<__cosim_s2__>(), __xlx_w2__tmp_vec.data(), __xlx_apatb_param_b2_0, __xlx_apatb_param_b2_1, __xlx_apatb_param_b2_2, __xlx_apatb_param_b2_3, __xlx_apatb_param_b2_4, __xlx_apatb_param_b2_5, __xlx_apatb_param_b2_6, __xlx_apatb_param_b2_7, __xlx_apatb_param_b2_8, __xlx_apatb_param_b2_9, __xlx_apatb_param_b2_10, __xlx_apatb_param_b2_11, __xlx_apatb_param_b2_12, __xlx_apatb_param_b2_13, __xlx_apatb_param_b2_14, __xlx_apatb_param_b2_15, __xlx_apatb_param_b2_16, __xlx_apatb_param_b2_17, __xlx_apatb_param_b2_18, __xlx_apatb_param_b2_19, __xlx_w4__tmp_vec.data(), __xlx_apatb_param_b4_0, __xlx_apatb_param_b4_1, __xlx_apatb_param_b4_2, __xlx_apatb_param_b4_3, __xlx_apatb_param_b4_4, __xlx_apatb_param_b4_5, __xlx_apatb_param_b4_6, __xlx_apatb_param_b4_7, __xlx_apatb_param_b4_8, __xlx_apatb_param_b4_9, __xlx_w7__tmp_vec.data());
sinput_1->transfer((hls::stream<__cosim_s2__>*)__xlx_apatb_param_input_1);
slayer8_out->transfer((hls::stream<__cosim_s2__>*)__xlx_apatb_param_layer8_out);
// print __xlx_apatb_param_w2
for (size_t i = 0; i < __xlx_size_param_w2; ++i) {
((Byte<2>*)__xlx_apatb_param_w2)[i] = __xlx_w2__tmp_vec[__xlx_offset_param_w2+i];
}
// print __xlx_apatb_param_w4
for (size_t i = 0; i < __xlx_size_param_w4; ++i) {
((Byte<2>*)__xlx_apatb_param_w4)[i] = __xlx_w4__tmp_vec[__xlx_offset_param_w4+i];
}
// print __xlx_apatb_param_w7
for (size_t i = 0; i < __xlx_size_param_w7; ++i) {
((Byte<2>*)__xlx_apatb_param_w7)[i] = __xlx_w7__tmp_vec[__xlx_offset_param_w7+i];
}
}
