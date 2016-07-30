# Change Log

## [v1.2.1](https://github.com/nubisproject/nubis-nat/tree/v1.2.1) (2016-07-30)
[Full Changelog](https://github.com/nubisproject/nubis-nat/compare/v1.2.0...v1.2.1)

**Implemented enhancements:**

- Consider moving route removal stuff out of eni-attach and into nubis-puppet-nat instead [\#72](https://github.com/nubisproject/nubis-nat/issues/72)
- \[puppet\] Pin nubis/nsm at a specific revision [\#25](https://github.com/nubisproject/nubis-nat/issues/25)
- \[puppet\] Pin nubis/nubis\_nat at a specific revision [\#24](https://github.com/nubisproject/nubis-nat/issues/24)

**Merged pull requests:**

- Update builder artifacts for v1.2.1 release [\#119](https://github.com/nubisproject/nubis-nat/pull/119) ([tinnightcap](https://github.com/tinnightcap))
- Pinning puppet nsm to v1.2.0 [\#117](https://github.com/nubisproject/nubis-nat/pull/117) ([limed](https://github.com/limed))
- Pin nubis-puppet-nat to version v1.2.0 [\#116](https://github.com/nubisproject/nubis-nat/pull/116) ([limed](https://github.com/limed))
- Update builder artifacts for v1.3.0-dev release [\#115](https://github.com/nubisproject/nubis-nat/pull/115) ([tinnightcap](https://github.com/tinnightcap))

## [v1.2.0](https://github.com/nubisproject/nubis-nat/tree/v1.2.0) (2016-07-07)
[Full Changelog](https://github.com/nubisproject/nubis-nat/compare/v1.1.0...v1.2.0)

**Implemented enhancements:**

- Point puppet-nsm to nubisproject org [\#107](https://github.com/nubisproject/nubis-nat/issues/107)
- Move to v1.2.0-dev cycle [\#99](https://github.com/nubisproject/nubis-nat/issues/99)

**Fixed bugs:**

- Fixing some dependency issues with supervisord [\#101](https://github.com/nubisproject/nubis-nat/issues/101)

**Closed issues:**

- Tag v1.2.0 release [\#113](https://github.com/nubisproject/nubis-nat/issues/113)
- Off by one error in VPC blocklist script [\#110](https://github.com/nubisproject/nubis-nat/issues/110)
- \[blocklist\] stop adding rules when we hit MAX\_RULES [\#103](https://github.com/nubisproject/nubis-nat/issues/103)
- \[blocklist\] Need to DENY not ALLOW offenders [\#93](https://github.com/nubisproject/nubis-nat/issues/93)
- Allow Squid traffic to come in from either interfaces, as long as its from [\#91](https://github.com/nubisproject/nubis-nat/issues/91)

**Merged pull requests:**

- Update CHANGELOG for v1.2.0 release [\#114](https://github.com/nubisproject/nubis-nat/pull/114) ([tinnightcap](https://github.com/tinnightcap))
- Update builder artifacts for v1.2.0 release [\#112](https://github.com/nubisproject/nubis-nat/pull/112) ([tinnightcap](https://github.com/tinnightcap))
- Small cleanup and off-by-one error [\#111](https://github.com/nubisproject/nubis-nat/pull/111) ([gozer](https://github.com/gozer))
- Another typo [\#109](https://github.com/nubisproject/nubis-nat/pull/109) ([tinnightcap](https://github.com/tinnightcap))
- Switch nubis-puppet-nsm org [\#108](https://github.com/nubisproject/nubis-nat/pull/108) ([limed](https://github.com/limed))
- Add missing link [\#106](https://github.com/nubisproject/nubis-nat/pull/106) ([tinnightcap](https://github.com/tinnightcap))
- Update doc with default entries. [\#105](https://github.com/nubisproject/nubis-nat/pull/105) ([tinnightcap](https://github.com/tinnightcap))
- Handle gracefully \(skip them\) blocklist that have more than MAX\_RULES\(18\) entries [\#104](https://github.com/nubisproject/nubis-nat/pull/104) ([gozer](https://github.com/gozer))
- Fixing dependency for supervisord by shuffling classes around [\#102](https://github.com/nubisproject/nubis-nat/pull/102) ([limed](https://github.com/limed))
- Bumping up to new dev cycle [\#100](https://github.com/nubisproject/nubis-nat/pull/100) ([limed](https://github.com/limed))
- Update README.md for NAT and IP Blocklist [\#98](https://github.com/nubisproject/nubis-nat/pull/98) ([tinnightcap](https://github.com/tinnightcap))

## [v1.1.0](https://github.com/nubisproject/nubis-nat/tree/v1.1.0) (2016-04-25)
**Implemented enhancements:**

- Move to the v1.0.2-dev train [\#28](https://github.com/nubisproject/nubis-nat/issues/28)
- Add comments for nat iptable rule [\#21](https://github.com/nubisproject/nubis-nat/issues/21)
- Update puppetfile to point nubis puppet nat to new location [\#61](https://github.com/nubisproject/nubis-nat/issues/61)
- Instead of waiting for the ENI to be available, just steal it [\#57](https://github.com/nubisproject/nubis-nat/issues/57)
- Filter out iptable logs to its own file and also send it to fluent [\#37](https://github.com/nubisproject/nubis-nat/issues/37)
- Merge nubis-proxy into nubis-nat [\#11](https://github.com/nubisproject/nubis-nat/issues/11)
- Manage iptable rules via confd [\#22](https://github.com/nubisproject/nubis-nat/pull/22) ([limed](https://github.com/limed))

**Fixed bugs:**

- \[bug\] Not calling curl to discover vpc\_cidr ip [\#33](https://github.com/nubisproject/nubis-nat/issues/33)
- \[bug\] Advertise address for consul never gets set now [\#32](https://github.com/nubisproject/nubis-nat/issues/32)
- Override proxy information [\#70](https://github.com/nubisproject/nubis-nat/issues/70)
- \[bug\] Remove additional ENI routes [\#63](https://github.com/nubisproject/nubis-nat/issues/63)
- \[bug\] sport and dport flipped for squid iptable rule [\#54](https://github.com/nubisproject/nubis-nat/issues/54)
- \[bug\] Bind everythin back to eth0 instead [\#45](https://github.com/nubisproject/nubis-nat/issues/45)
- Bind consul to eth1 [\#38](https://github.com/nubisproject/nubis-nat/issues/38)
- Nat instance needs to report its interface IP [\#13](https://github.com/nubisproject/nubis-nat/issues/13)

**Closed issues:**

- Bump down number of nat instance to 1 [\#88](https://github.com/nubisproject/nubis-nat/issues/88)
- ENI detach logic is broken, it doesn't actually retry as it should [\#85](https://github.com/nubisproject/nubis-nat/issues/85)
- Fix ENI startup issues [\#83](https://github.com/nubisproject/nubis-nat/issues/83)
- Use Facter to find our VPC cidr range [\#82](https://github.com/nubisproject/nubis-nat/issues/82)
- Detach our ENI if attached before attaching it [\#80](https://github.com/nubisproject/nubis-nat/issues/80)
- Check nubis metadata for our assigned EIP before peeking at cloudformation [\#78](https://github.com/nubisproject/nubis-nat/issues/78)
- Upgrade git to 2.7.3 [\#66](https://github.com/nubisproject/nubis-nat/issues/66)
- \[blocklist\] region us-west-2 hardcoded in 2 places [\#64](https://github.com/nubisproject/nubis-nat/issues/64)
- Instead of needing confd to inject VPC information, consider using facter [\#56](https://github.com/nubisproject/nubis-nat/issues/56)
- Interface fixup script bug [\#52](https://github.com/nubisproject/nubis-nat/issues/52)
- Bump timeout for eni-attach script [\#50](https://github.com/nubisproject/nubis-nat/issues/50)
- Make the blocklist configurable and default to opsec's list [\#47](https://github.com/nubisproject/nubis-nat/issues/47)
- Fix startup ordering to cooperate nicely with the new wait-for-consul in base [\#43](https://github.com/nubisproject/nubis-nat/issues/43)
- Create a basic masquerade rule during bootup [\#41](https://github.com/nubisproject/nubis-nat/issues/41)
- Advertise eth1 as the Consul address, since it's effectively our \*inside\* address. [\#29](https://github.com/nubisproject/nubis-nat/issues/29)
- POC: Implement an IP blocklisting service [\#23](https://github.com/nubisproject/nubis-nat/issues/23)
- Modify ENI attach script to look at different tags [\#6](https://github.com/nubisproject/nubis-nat/issues/6)
- Clean up cloudformation [\#4](https://github.com/nubisproject/nubis-nat/issues/4)
- EIP attach script will not attach [\#1](https://github.com/nubisproject/nubis-nat/issues/1)
- Move services back to eth1 now [\#59](https://github.com/nubisproject/nubis-nat/issues/59)
- Allow only specific port to connect to NAT instance [\#20](https://github.com/nubisproject/nubis-nat/issues/20)
- Install NSM on base image [\#3](https://github.com/nubisproject/nubis-nat/issues/3)

**Merged pull requests:**

- Correctly use the action passed into create\_acl\(\) [\#94](https://github.com/nubisproject/nubis-nat/pull/94) ([gozer](https://github.com/gozer))
- Allow Squid traffic inbound on any interfaces [\#92](https://github.com/nubisproject/nubis-nat/pull/92) ([gozer](https://github.com/gozer))
- Update CHANGELOG for v1.1.0 release [\#90](https://github.com/nubisproject/nubis-nat/pull/90) ([tinnightcap](https://github.com/tinnightcap))
- Update versions for  release [\#89](https://github.com/nubisproject/nubis-nat/pull/89) ([tinnightcap](https://github.com/tinnightcap))
- Implement FORWARDing [\#87](https://github.com/nubisproject/nubis-nat/pull/87) ([gozer](https://github.com/gozer))
- Fix bug that caused ENI detaching logic not to wait for it to actually detach [\#86](https://github.com/nubisproject/nubis-nat/pull/86) ([gozer](https://github.com/gozer))
- Use facter to find our VPC cidr range. [\#84](https://github.com/nubisproject/nubis-nat/pull/84) ([gozer](https://github.com/gozer))
- Detach our ENI if already atached, before grabbing it. [\#81](https://github.com/nubisproject/nubis-nat/pull/81) ([gozer](https://github.com/gozer))
- check metadata for assigned EIP first [\#79](https://github.com/nubisproject/nubis-nat/pull/79) ([gozer](https://github.com/gozer))
- Move some NAT services back to eth1 which means tweaking firewall rules [\#77](https://github.com/nubisproject/nubis-nat/pull/77) ([limed](https://github.com/limed))
- Remove debugging code [\#76](https://github.com/nubisproject/nubis-nat/pull/76) ([limed](https://github.com/limed))
- Filter out iptable log to its own file and send it out via fluent [\#75](https://github.com/nubisproject/nubis-nat/pull/75) ([limed](https://github.com/limed))
- Steal ENI instead of waiting for it to be available [\#74](https://github.com/nubisproject/nubis-nat/pull/74) ([limed](https://github.com/limed))
- Remove redundant route [\#73](https://github.com/nubisproject/nubis-nat/pull/73) ([limed](https://github.com/limed))
- Override proxy information [\#71](https://github.com/nubisproject/nubis-nat/pull/71) ([limed](https://github.com/limed))
- Fixing return value for eni-attach script [\#69](https://github.com/nubisproject/nubis-nat/pull/69) ([limed](https://github.com/limed))
- Fixing routes when ENI gets attached [\#68](https://github.com/nubisproject/nubis-nat/pull/68) ([limed](https://github.com/limed))
- Latest git in Amazon Linux is 2.7.3-1.46.amzn1 [\#67](https://github.com/nubisproject/nubis-nat/pull/67) ([gozer](https://github.com/gozer))
- Use detected region [\#65](https://github.com/nubisproject/nubis-nat/pull/65) ([gozer](https://github.com/gozer))
- Puppetfile update [\#62](https://github.com/nubisproject/nubis-nat/pull/62) ([limed](https://github.com/limed))
- Destination and source port was flipped also splitting out protocols [\#55](https://github.com/nubisproject/nubis-nat/pull/55) ([limed](https://github.com/limed))
- Point mac address to the proper variable [\#53](https://github.com/nubisproject/nubis-nat/pull/53) ([limed](https://github.com/limed))
- Bump the timeout for eni-associate script [\#51](https://github.com/nubisproject/nubis-nat/pull/51) ([limed](https://github.com/limed))
- Implement a firewall on the nat instance [\#49](https://github.com/nubisproject/nubis-nat/pull/49) ([limed](https://github.com/limed))
- Change default blacklist polling location and disable GPG verification by default [\#48](https://github.com/nubisproject/nubis-nat/pull/48) ([gozer](https://github.com/gozer))
- Due to vpc / routing limitation we need to make services go out eth0 [\#46](https://github.com/nubisproject/nubis-nat/pull/46) ([limed](https://github.com/limed))
- Fixing ordering for the new consul-wait in base. [\#44](https://github.com/nubisproject/nubis-nat/pull/44) ([gozer](https://github.com/gozer))
- Create a simple masquerade rule during startup [\#42](https://github.com/nubisproject/nubis-nat/pull/42) ([limed](https://github.com/limed))
- Bind consul to eth1 [\#40](https://github.com/nubisproject/nubis-nat/pull/40) ([limed](https://github.com/limed))
- Fixing advertise\_addr  [\#36](https://github.com/nubisproject/nubis-nat/pull/36) ([limed](https://github.com/limed))
- Ignore builder build artifacts [\#35](https://github.com/nubisproject/nubis-nat/pull/35) ([limed](https://github.com/limed))
- Fixes issue \#33, vpc cidr ip not being set since we're not calling curl [\#34](https://github.com/nubisproject/nubis-nat/pull/34) ([limed](https://github.com/limed))
- Pin base image to specific image, fixes issue \#28 [\#31](https://github.com/nubisproject/nubis-nat/pull/31) ([limed](https://github.com/limed))
- Move Consul advertisement to eth1 [\#30](https://github.com/nubisproject/nubis-nat/pull/30) ([gozer](https://github.com/gozer))
- POC: Implement a VPC blocklisting process. [\#26](https://github.com/nubisproject/nubis-nat/pull/26) ([gozer](https://github.com/gozer))
- Updated readme with some NSM information [\#19](https://github.com/nubisproject/nubis-nat/pull/19) ([limed](https://github.com/limed))
- Include nsm puppet class, this installs nsm on the nat instances [\#17](https://github.com/nubisproject/nubis-nat/pull/17) ([limed](https://github.com/limed))
- Nubis proxy merge [\#15](https://github.com/nubisproject/nubis-nat/pull/15) ([limed](https://github.com/limed))
- Include advertise-addr config, we need this since NAT instances has 2 interfaces [\#14](https://github.com/nubisproject/nubis-nat/pull/14) ([limed](https://github.com/limed))
- Bump metadata [\#10](https://github.com/nubisproject/nubis-nat/pull/10) ([limed](https://github.com/limed))
- Fixing filters to be more specific [\#9](https://github.com/nubisproject/nubis-nat/pull/9) ([limed](https://github.com/limed))
- Project metadata bump [\#8](https://github.com/nubisproject/nubis-nat/pull/8) ([limed](https://github.com/limed))
- Tweak eni filters to search for a particular keyword instead [\#7](https://github.com/nubisproject/nubis-nat/pull/7) ([limed](https://github.com/limed))
- Clean cloudformation template [\#5](https://github.com/nubisproject/nubis-nat/pull/5) ([limed](https://github.com/limed))
- Nested stack output lookup support [\#2](https://github.com/nubisproject/nubis-nat/pull/2) ([limed](https://github.com/limed))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*