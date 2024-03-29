module RSA
  def moddpow(base, power, modulus)
    m=base
    pow = power.to_s(2)
    1.upto(pow.length - 1) do |i|
      m *= m
      m %= modulus
      if pow[i] == "1"[0]
        m *= base
        m %= modulus
      end
    end
    m
  end

  def euclid(a,b)
    #taking numbers a and b return the GCD of both of them
    temp = 0

    if a < b
      a, b = b, a #swap a and b
    end

    while (b != 0)
      temp = a % b
      a = b
      b = temp
    end
    return a
  end

  def keygen(p, q)
    puts "Got p: #{p} q: #{q}"

    n = p * q
    puts "N = #{n}"

    phi = (p-1) * (q-1)

    puts "Phi: #{phi}"
    possible_e = []
    (2..phi-1).each do |i|

      gcd = euclid(i, phi)
      possible_e.push i if gcd == 1
    end
    abort "Could not find e" if possible_e.size == 0
    e = possible_e.sample
    puts "e: #{e}"

    d = e^-1 % phi
    puts "d: #{d}"

    #n is modulus
    #e is public exponent
    #d is secret exponent

    return {n: n, e: e, d: d}
  end
  def quick_fermat(num)
    if (num < 2)
      false
    else
      #if (2 ** (num-1) % num == 1)
      if modPow(2,num-1,num) == 1
        true
      else
        false
      end
    end
  end
  def bit_length(num)
    bits = num.to_s(2).length
    puts bits
    bits
  end

  def random_number(bits, num_of_flips)
    #generate number
    largest_number = (2 ** bits).to_s(2)
    (1..num_of_flips).each do |i|
      flip = rand(largest_number.length)
      largest_number[flip] = (largest_number[flip] == '0') ? '1' : '0'
    end
    largest_number.to_i(2)
  end

# Copyright (c) 2012 the authors listed at the following URL, and/or
# the authors of referenced articles or incorporated external code:
# http://en.literateprograms.org/Miller-Rabin_primality_test_(Ruby)?action=history&offset=20090326153929
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Retrieved from: http://en.literateprograms.org/Miller-Rabin_primality_test_(Ruby)?oldid=16299

  def modPow(x, r, m)
      y = r
      z = x
      v = 1
      while y > 0
          u = y % 2
          t = y / 2
          if u == 1
              v = (v * z) % m
          end
          z = z * z % m
          y = t
      end
      return v
  end

  def miller_rabin_pass(a, n)
      d = n - 1
      s = 0
      while d % 2 == 0 do
          d >>= 1
          s += 1
      end

      a_to_power = modPow(a, d, n)
      if a_to_power == 1
          return true
      end
      for i in 0...s do
          if a_to_power == n - 1
              return true
          end
          a_to_power = (a_to_power * a_to_power) % n
      end
      return (a_to_power == n - 1)
  end


  def miller_rabin(n, k)
      for i in 0...k do
          a = 0
          while a == 0
               a = rand(n)
          end
          if (!miller_rabin_pass(a, n))
              return false
          end
      end
      return true
  end





end