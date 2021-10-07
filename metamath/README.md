# Metamath

*[Metamath](http://us.metamath.org/) is a tiny language that can express theorems in abstract mathematics, accompanied by proofs that can be verified by a computer program. This site has a collection of web pages generated from those proofs and lets you see mathematics developed in complete detail from first principles, with absolute rigor. Hopefully it will amuse you, amaze you, and possibly enlighten you in its own special way.*

## Metamath on WAPM

This metamath has been slightly patched to be able to run on WASI. Most notably, the ability to execute shell commands has been removed. It only contains the metamath main executable, but no additional `.mm` databases. `set.mm` has to be acquired manually from [github](https://github.com/metamath/set.mm) or [metamath.org](http://us.metamath.org/metamath/set.mm).

You can try [running it on webassembly.sh](https://webassembly.sh/?run-command=curl%20https://raw.githubusercontent.com/metamath/set.mm/d3dc8f9545186d55b90dd8f4d89ff8e2ec2a3b93/demo0.mm%20-o%20demo0.mm%20|%20metamath%20%22read%20demo0.mm%22%20%22verify%20proof%20%2A%22%20exit):

```
$ curl https://raw.githubusercontent.com/metamath/set.mm/d3dc8f9545186d55b90dd8f4d89ff8e2ec2a3b93/set.mm -o set.mm
$ metamath "read set.mm" "verify proof *" exit
Metamath - Version 0.198 7-Aug-2021           Type HELP for help, EXIT to exit.
MM> read set.mm
Reading source file "set.mm"... 42913743 bytes
42913743 bytes were read into the source buffer.
The source has 201512 statements; 2673 are $a and 39622 are $p.
No errors were found.  However, proofs were not checked.  Type VERIFY PROOF *
if you want to check them.
MM> verify proof *
0 10%  20%  30%  40%  50%  60%  70%  80%  90% 100%
..................................................
All proofs in the database were verified in 17.59 s.
MM> exit
```

(If you're using a browser plugin to block third-party XHR like uMatrix, make sure to let curl through, or else it will fail silently.)
