# libseccomp2-perf-test

Scripts to run a Docker performance test to compare (if)efficiency of different `libseccomp2`.

[Background on `libseccomp2` performance degradation](https://github.com/seccomp/libseccomp/issues/153)

## About the testing procedure

This testing procedure was defined by xinfengliu in the [libseccomp issue](https://github.com/seccomp/libseccomp/issues/153#issuecomment-549274260) and has been adapted to be able to run in a single command for a consistent benchmark between versions to remove the human element in testing.

If you want to test `libseccomp2=2.2.3-3ubuntu3`, for Docker EE 17.06, you need to install `docker-ee=3:17.06.2~ee~24~3-0~ubuntu` because `docker-ee=3:17.06.2~ee~25~3-0~ubuntu` requires a newer version of libseccomp.

## List the versions of `libseccomp2` available

Ubuntu 16.04:

```
libseccomp2 | 2.4.1-0ubuntu0.16.04.2 | http://us.archive.ubuntu.com/ubuntu xenial-updates/main amd64 Packages
libseccomp2 | 2.4.1-0ubuntu0.16.04.2 | http://security.ubuntu.com/ubuntu xenial-security/main amd64 Packages
libseccomp2 | 2.2.3-3ubuntu3 | http://us.archive.ubuntu.com/ubuntu xenial/main amd64 Packages
```

Ubuntu 18.04:

```
# apt-cache madison libseccomp2
libseccomp2 | 2.4.1-0ubuntu0.18.04.2 | http://us.archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages
libseccomp2 | 2.4.1-0ubuntu0.18.04.2 | http://us.archive.ubuntu.com/ubuntu bionic-security/main amd64 Packages
libseccomp2 | 2.3.1-2.1ubuntu4 | http://us.archive.ubuntu.com/ubuntu bionic/main amd64 Packages
```

## Testing procedure

1. Stop Docker:

   ```
   systemctl stop docker
   ```

1. Install the specifc version of `libseccomp2` you wish to test:

   ```
   apt-get install libseccomp2=2.2.3-3ubuntu3
   ```

1. Start Docker:

   ```
   systemctl start docker
   ```

1. Execute test with 40 execs:

   ```
   # ./docker-libseccomp-test.sh 40
   Launching test container...done
   Running exec tests...done

   ii  libseccomp2:amd64 2.2.3-3ubuntu3 amd64
   0.21
   0.23
   3.73
   3.73
   3.73
   3.73
   3.73
   3.73
   3.73
   3.74
   3.74
   3.74
   3.74
   3.74
   3.74
   3.74
   3.75
   3.75
   3.75
   3.75
   3.75
   3.75
   3.75
   3.75
   3.75
   3.76
   3.76
   3.76
   3.76
   3.76
   3.76
   3.77
   3.77
   3.77
   3.77
   3.77
   3.77
   3.77
   3.77
   3.78

   Min: 0.21
   Max: 3.78
   Avg: 3.57

   Stopping and removing test container...done
   ```
