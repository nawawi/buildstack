patch -p1 < ../patches/openssl-1.0.1-beta2-rpmbuild.patch
patch -p1 < ../patches/openssl-1.0.0f-defaults.patch
patch -p1 < ../patches/openssl-1.0.0-beta5-enginesdir.patch
patch -p1 < ../patches/openssl-0.9.8a-no-rpath.patch
patch -p1 < ../patches/openssl-0.9.8b-test-use-localhost.patch
patch -p1 < ../patches/openssl-1.0.0-timezone.patch
patch -p1 < ../patches/openssl-1.0.1c-perlfind.patch
patch -p1 < ../patches/openssl-1.0.1c-aliasing.patch
patch -p1 < ../patches/openssl-1.0.1c-default-paths.patch
patch -p1 < ../patches/openssl-1.0.1e-issuer-hash.patch
patch -p1 < ../patches/openssl-1.0.0-beta4-ca-dir.patch
patch -p1 < ../patches/openssl-0.9.6-x509.patch
patch -p1 < ../patches/openssl-0.9.8j-version-add-engines.patch
patch -p1 < ../patches/openssl-1.0.0e-doc-noeof.patch
patch -p1 < ../patches/openssl-1.0.1-beta2-ssl-op-all.patch
patch -p1 < ../patches/openssl-1.0.1c-ipv6-apps.patch
patch -p1 < ../patches/openssl-1.0.1e-fips.patch
patch -p1 < ../patches/openssl-1.0.0-beta5-readme-warning.patch
patch -p1 < ../patches/openssl-1.0.1a-algo-doc.patch
patch -p1 < ../patches/openssl-1.0.1-beta2-dtls1-abi.patch
patch -p1 < ../patches/openssl-1.0.1-version.patch
patch -p1 < ../patches/openssl-1.0.0c-rsa-x931.patch
patch -p1 < ../patches/openssl-1.0.1-beta2-fips-md5-allow.patch
patch -p1 < ../patches/openssl-1.0.0d-apps-dgst.patch
patch -p1 < ../patches/openssl-1.0.0d-xmpp-starttls.patch
patch -p1 < ../patches/openssl-1.0.0e-chil-fixes.patch
patch -p1 < ../patches/openssl-1.0.1-pkgconfig-krb5.patch
[[ $_GCCV < '4.8' ]] && {
    patch -p1 < ../patches/openssl-1.0.1e-env-zlib.patch;
    patch -p1 < ../patches/openssl-1.0.1e-secure-getenv.patch;
}
patch -p1 < ../patches/openssl-1.0.1c-dh-1024.patch
patch -p1 < ../patches/openssl-1.0.1-beta2-padlock64.patch
patch -p1 < ../patches/openssl-1.0.1e-backports.patch
patch -p1 < ../patches/openssl-1.0.1e-bad-mac.patch

# fix pod syntax
if [[ $_PERLV = '5.18' ]] || [[ $_PERLV > '5.18' ]]; then
    for f in $(find . -name "*.pod"); do
        sed -i -e 's/=item\s\([0-9]\+\)/=item C\<\1\>/g' -e 's/=item\s\([-0-9]\+\)/=item C\<\1\>/g' $f;
    done
fi
exit;
