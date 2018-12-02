# bash-cache

Simple cache for shell scripts. Did not find one, wrote one.

## Example

The first call takes about 1201ms while the following cached call is only 29ms. Almost 42 times faster!

    $ time ./bash-cache elinks --dump kernel.org | tail -n 1
    91. https://www.linuxfoundation.org/
    ./bash-cache elinks --dump kernel.org  0.05s user 0.05s system 8% cpu 1.201 total
    tail -n 1  0.00s user 0.00s system 0% cpu 1.199 total

    $ time ./bash-cache elinks --dump kernel.org | tail -n 1
    91. https://www.linuxfoundation.org/
    ./bash-cache elinks --dump kernel.org  0.01s user 0.02s system 102% cpu 0.029 total
    tail -n 1  0.00s user 0.00s system 18% cpu 0.028 total

## TODO

* There is currently no option for deleting the cache. Calls will always be cached.