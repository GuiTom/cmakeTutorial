#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Demo8-1.0.1-Darwin subdirectory
  --exclude-subdir  exclude the Demo8-1.0.1-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Demo8 Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
The MIT License (MIT)

Copyright (c) 2013 Joseph Pan(http://hahack.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Demo8 will be installed in:"
    echo "  \"${toplevel}/Demo8-1.0.1-Darwin\""
    echo "Do you want to include the subdirectory Demo8-1.0.1-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Demo8-1.0.1-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +170 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Demo8-1.0.1-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� -: b ���kG��%�TŜ-��W�ULf�GՋu�;��6�A��۽�һ���g0H� �e�_ai����}�B��}QJ*��B_��3�{�͚�4������{��gg.�ۘ3�n��(������=^O�I��Ir2.S�HQH�x*�$Rj����Z��|Q7�E��,��
���ѿ r����妏�o����L{��I��O$R)"ѭ,��%?�����vBZZ�8���n��9���_�-�c�?P�(]x:G�3�G�Yhy�����O����@#n�>��Oz�~�ۂy��Tpʘ�Tsv�|{Oy����u~�m��^խ�Q}_`ٴ���X�9Ҥ���o 0�����Us�05f�������e�p� q�_�y�����.y�ҡs��~1Qw�H%p�M�u��<��x���su�yL��ڸ��33VR�=Q�UJlԱ���`]�w�����i����sm.M�N)�/l��s ;xN9����|�9置����{|�WN�8q����[Ǽ����{'҈����Q�B�y������H����!L���	�M����[wն�KF�[�(i��o�u�R9��u��~���?<�3�s���Wղ�{{y?r�x߻�#��E��E��/���n]��6��Qo�cǺ�.^��s�����@{8~h�v�r�i��-�����������                           ��23�f����'b:3����.OO��v�:�/df���,��z�1��&��yǃŻ�KZ#`��v�Ov�Qj��h�H�,���17$��f'kq?~��R]��������z7U�*O2���ջ�9�ިX�23�H,^y�y����k���{ѫw�Vc�iBVcܟ5��oi�j�֛K|�?��çsEqq����jQ�������?�~��b�-]���)fK9��%}|�b�#� ��1iL����S�%�QMM�4�d�,՚��!���$Öb#;��X����������$��^�]p1ｊ7`�ko�>�k�                               �����������S�                               �˞�dX�������l��c9��t�|h�9b�O��T
b��1���heL���e���ka��DX���q=_utV�U��`Y5L��V2���q��s�󶛏�Oz�g1� D���bYgKԻo{�9!i?~�w=R/�Ph~$4?��B�6��y���v�:6�&H�m��}Vo���s���[Om9cW<"�����`L>���zZ���eU����hr°�jN��;F>;�%u]-U�&��F���	��j��g��h);8D�	�K��+�������(Jҙ�o�+s��_W��|����0󥪦wo�=(������=^O�I��Ir2.S�HQH�D��)��E�UmG�x)��n�j�Y+6��?G�A��?_1�HWq+����'�����r���=I����=D�[QL�K~��5�`�����Xa/|��.  ��� [q�� �  