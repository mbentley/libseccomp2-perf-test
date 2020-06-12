# libseccomp2-perf-test

Scripts to run a Docker performance test to compare (if)efficiency of different `libseccomp2`.

[Background on `libseccomp2` performance degradation](https://github.com/seccomp/libseccomp/issues/153)

## List the versions of `libseccomp2` availabl

```
# apt-cache madison libseccomp2
libseccomp2 | 2.4.1-0ubuntu0.18.04.2 | http://us.archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages
libseccomp2 | 2.4.1-0ubuntu0.18.04.2 | http://us.archive.ubuntu.com/ubuntu bionic-security/main amd64 Packages
libseccomp2 | 2.3.1-2.1ubuntu4 | http://us.archive.ubuntu.com/ubuntu bionic/main amd64 Packages
```

## Testing procedure for 2.3.x

1. Stop Docker:

   ```
   systemctl stop docker
   ```

1. Install `libseccomp2` 2.3.x:

   ```
   apt-get install libseccomp2=2.3.1-2.1ubuntu4
   ```

1. Start Docker:

   ```
   systemctl start docker
   ```

1. Execute test with 20 containers:

   ```
   # ./0_runall.sh 20
   Launching containers...done
   ii  libseccomp2:amd64 2.3.1-2.1ubuntu4 amd64        high level interface to Linux seccomp filter

   0:01.52 real
   0:01.51 real
   0:01.51 real
   0:01.51 real
   0:01.51 real
   0:01.52 real
   0:01.51 real
   0:01.50 real
   0:01.52 real
   0:01.51 real
   0:01.51 real
   0:01.52 real
   0:01.52 real
   0:01.51 real
   0:01.52 real
   0:01.51 real
   0:01.51 real
   0:01.51 real
   0:01.52 real
   0:01.51 real
   Removing containers...done
   ```

## Testing procedure for 2.4.x

1. Stop Docker:

   ```
   systemctl stop docker
   ```

1. Install `libseccomp2` 2.4.x:

   ```
   apt-get install libseccomp2=2.4.1-0ubuntu0.18.04.2
   ```

1. Start Docker:

   ```
   systemctl start docker
   ```

1. Execute test with 20 containers:

   ```
   # ./0_runall.sh 20
   Launching containers...done
   ii  libseccomp2:amd64 2.4.1-0ubuntu0.18.04.2 amd64        high level interface to Linux seccomp filter

   0:04.54 real
   0:04.54 real
   0:04.52 real
   0:04.54 real
   0:04.54 real
   0:04.54 real
   0:04.53 real
   0:04.54 real
   0:04.55 real
   0:04.53 real
   0:04.53 real
   0:04.55 real
   0:04.55 real
   0:04.55 real
   0:04.55 real
   0:04.53 real
   0:04.55 real
   0:04.54 real
   0:04.55 real
   0:04.55 real
   Removing containers...done
   ```
