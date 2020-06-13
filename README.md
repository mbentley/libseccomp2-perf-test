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

## Automatically test multiple versions of `docker-ee` and `libseccomp2`

This will test all of the combinations of the `docker-ee` and `libseccomp2` packages defined in `multi-version-test.sh` automatically:

```
./multi-version-test.sh > multi-out.log
```

This will also generate output in CSV format `test_results.csv`.

## Testing a specific set of versions

1. Install the specific version of `docker-ee` you wish to test:

   ```
   apt-get install docker-ee=17.06.1~ee~1-0~ubuntu
   ```

1. Install the specifc version of `libseccomp2` you wish to test:

   ```
   apt-get install libseccomp2=2.2.3-3ubuntu3
   ```

1. Execute test with 40 execs; looped 10 times with the default seccomp profile used on the container:

   ```
   # DISABLE_SECCOMP=false ./multi-test.sh 10 40

   Loop 1
   Min: 1.59
   Max: 3.87
   Avg: 3.78

   Loop 2
   Min: 1.40
   Max: 3.86
   Avg: 3.72

   Loop 3
   Min: 0.17
   Max: 3.84
   Avg: 3.53

   Loop 4
   Min: 3.83
   Max: 3.87
   Avg: 3.85

   Loop 5
   Min: 0.25
   Max: 3.71
   Avg: 3.47

   Loop 6
   Min: 0.20
   Max: 3.65
   Avg: 3.45

   Loop 7
   Min: 0.15
   Max: 3.71
   Avg: 3.35

   Loop 8
   Min: 2.65
   Max: 3.89
   Avg: 3.71

   Loop 9
   Min: 0.35
   Max: 3.70
   Avg: 3.59

   Loop 10
   Min: 3.59
   Max: 3.74
   Avg: 3.72

   Average stats from 10 tests on docker-ee=3:17.06.2~ee~24~3-0~ubuntu for libseccomp2=2.2.3-3ubuntu3:
   Avg Min: 1.42
   Avg Max: 3.78
   Avg Avg: 3.62
   ```

