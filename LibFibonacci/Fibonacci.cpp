unsigned int Fibonacci(unsigned int nOfElementIndex)
{
  unsigned int nF0 = 0;
  unsigned int nFib = 1;
  for ( unsigned int i = 0; i <= nOfElementIndex; ++i )
  {
    nF0 += nFib;
    nFib = nF0 - nFib;
  }
  return nFib;
}
