#pragma once

#include <iosfwd>
#include <vector>
#include <string>

class Cave;

class Scan
{
public:
  Scan();

  void repeat(size_t n);

  size_t width() const;
  size_t height() const;
  size_t repeat() const;

  const std::vector<std::string>& data() const;

  class Iterator
  {
  public:
    Iterator(const Scan& s, size_t i);

    bool operator!=(const Iterator& rhs) const;
    Iterator& operator++();

    const std::vector<size_t>& operator*() const;

  protected:
    void update();

  protected:
    const Scan& _s;
    size_t _i; 

    std::vector<size_t> _row;
  };

  Iterator begin() const;
  Iterator end() const;

protected:
  friend std::istream& operator>>(std::istream& is, Scan& s);

protected:
  std::vector<std::string> _scan;
  size_t _repeat;
};

