import groovy.yaml.*

def ys = new YamlSlurper()

def yaml = ys.parseText '''
language: groovy
sudo: required
dist: trusty

matrix:
  include:
    - jdk: openjdk10
    - jdk: oraclejdk9
    - jdk: oraclejdk8

before_script:
  - |
    unset _JAVA_OPTIONS

        '''

println yaml
println 'This is a script!'
