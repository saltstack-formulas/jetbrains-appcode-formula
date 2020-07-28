# Changelog

## [1.0.2](https://github.com/saltstack-formulas/jetbrains-appcode-formula/compare/v1.0.1...v1.0.2) (2020-07-28)


### Bug Fixes

* **cmd.run:** wrap url in quotes (zsh) ([86c256b](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/86c256b657f12bf882dd9b20886ac8bd9377ede9))
* **macos:** correct syntax ([36292b4](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/36292b448e1dfd17f0eed6f24e4d9c768ed3d1ab))


### Code Refactoring

* **jetbrains:** align all jetbrains formulas ([ffc4b97](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/ffc4b9727264b5ba3c5ca804db5fb6b661797a1f))
* **macos:** handle /applications ([d153a67](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/d153a67a6750d5f3e02f70f75a4562f7b5317dde))
* **path:** consistent path vars ([2338c2d](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/2338c2d0ea345f984786edb48496c7c4502d52fc))


### Continuous Integration

* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([c44d043](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/c44d0433363c1cbc8d861ebc903189798c55e10d))


### Documentation

* **readme:** minor update ([73b1d8b](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/73b1d8b1d9285776689ef776d064c0d3277d6bda))


### Styles

* **libtofs.jinja:** use Black-inspired Jinja formatting [skip ci] ([b8e7867](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/b8e7867ac18b73e0f9549ff215e46963143def3e))

## [1.0.1](https://github.com/saltstack-formulas/jetbrains-appcode-formula/compare/v1.0.0...v1.0.1) (2020-06-15)


### Bug Fixes

* **edition:** better edition jinja code ([ad2f797](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/ad2f79795633da937d8e2feb9cd20ae840c507e8))


### Continuous Integration

* **kitchen+travis:** add new platforms [skip ci] ([ddf769b](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/ddf769be52a84b94fb49afb7a526d72d4bfeeb0f))


### Documentation

* **readme:** update formattings ([2969be7](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/2969be7ee177606ac7cd3a7fe7f8d4d93c0d1ef9))

# [1.0.0](https://github.com/saltstack-formulas/jetbrains-appcode-formula/compare/v0.1.0...v1.0.0) (2020-05-22)


### Bug Fixes

* **id:** rename conflicting id ([f4055ff](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/f4055fffa98d03176c90b7164ba05b7697d632aa))
* **state:** remove duplicate include ([270a60f](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/270a60fcf436033d5eba784ed44d3ab822bb7000))
* **state:** remove duplicate include ([24cecda](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/24cecdadfa656546d7d78725d6335b4bcf3bbf03))


### Continuous Integration

* **kitchen+travis:** adjust matrix to add `3000.3` ([d2c5950](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/d2c5950345e9fc7179ecb5c91d0cb6dfeb5f097a))
* **travis:** update travis tests ([31094d7](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/31094d7865b52e2d32dddb51b90ba279bce4c5b9))


### Documentation

* **readme:** add depth one ([a0f9a4c](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/a0f9a4c77e4a8e2ec3dcb2182d6402c5f0116bd6))


### Features

* **formula:** align to template-formula; add ci ([bc70a97](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/bc70a976381b909ebaef96cc60047fbc44510859))
* **formula:** align to template-formula; add ci ([dd34d6e](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/dd34d6eed766029e415700cd5a852549a0896ec0))
* **semantic-release:** standardise for this formula ([feb0784](https://github.com/saltstack-formulas/jetbrains-appcode-formula/commit/feb078410ec61657b23b62be31f0bbd1e0f885a1))


### BREAKING CHANGES

* **formula:** Major refactor of formula to bring it in alignment with the
template-formula. As with all substantial changes, please ensure your
existing configurations work in the ways you expect from this formula.
