�Z3ENV ��s�1�!^6 #�>�2j* ͑"	�����"�'0��"n!� F#͚ʺ�/2kº#~�/º�T

ZSCFG2 Ver 2.0b - Examine/Set ZSDOS Vers 2 parameters

  Syntax:

     ZSCFG                - Interactive
     ZSCFG o[p],[o[p]],.. - Expert Mode

  Options [parameters]:

     P [-] Public Files        R [-] Read/Only sustain
     ! [-] Disk Change Alert   F [-] Fast Relog
     W [-] Public/Path Write   S [-] Path w/o SYStem
     C [ -, B or Hex value ]     Clock address
     * [ -, Z, or Hex value ]    Wheel write protect
     > [ -, Z, I, or Hex value ] DOS Search Path

     + [ A, C, M ][ - ] Access, Create, Modify Time Stamps

[more].. ����>�)͢�T  Examples:

       ZSCFG2 *Z,P,!-
    (ZCPR3 Wheel, Public ON, Warning OFF)

       ZSCFG2 CE800 F R
    (Clock Routine=E800H, Fast Relog ON, R/O Sustain ON)

       ZSCFG2 CB,>I
    (Clock=Bios+4EH, Int Path)

  Note:
       Delimiters are : TAB, SPACE and Comma

 ��T
ZSCFG2 V2.0b   Copyright (C) 1991/2   Harold F. Bower/Cameron W. Cotrill

 :k�̾:o�S�':n� 00�T
+++ Must have ZSDOS 2.0 or later +++
 ���T  ...Configuring ZSDOS Ver  ���Q�)>.�)��U�)��:k� e*	|� "�T
No Z3 Environment Found
 �<�O(Z3 Environment at  :  *	͇͏(ZCPR Path Address  :  	 *	^#V�"b:k� ͇͏-Wheel Byte at :  ) *	^#V�"d:k� ͇��*	|�8 ��~(
!B ^#V�: �g. "^��� ��"`:k��=��͎͢!���T       1 - Public Files           :  �*`�� F��T
       2 - Pub/Path Write Enable  :  �*`�� N��T
       3 - Read-Only Vector       :  �*`�� V��T
       4 - Fast Fixed Disk Log    :  �*`�� ^��T
       5 - Disk Change Warning    :  �*`�� f��T
       6 - Path w/o System Attr   :  �*`�� v��T
       7 - DOS Search Path        :  �*`�� n(F�TEnabled �*`�^��V��n�f	��R �T - Internal !�T  Addr =  ��~�TDisabled ͢�T
       8 - Wheel Byte Protect     :  �*`�n��f�|�( ��TEnabled  Addr =  ��~͢�TDisabled..Assumed ON ͢�T
       T - Time Routine (Clock)   :  �*`�n�f�]�T
       A - Stamp Last Access Time :  >�:�T
       C - Stamp Create Time      :  >�:�T
       M - Stamp Modify Time      :  >�:��!��͢�OEntry to Change ("X" to EXIT) :  ͢���4� 8��)�X���1��2��3��4��5�@�6��7´
͏DOS Path [(D)isable, (S)et, (I)nternal *	|�(�T, (Z)CPR3 �T] :  ���D(;�Z(B�I �*`�n�f	=�S �͏Enter PATH Address :  !  ���*`�� ��t*	|��t*b�*`�� ��t��u��t�8�K͏WHEEL Addr [(D)isable, (S)et *	|�(�T, (Z)CPR3 �T] :  ��!  �D(7�Z((�S �͏Enter WHEEL Address :  !  ��*	|��t*d�*`�t��u��t�T ,͏Time (Clock) ͕�*`�u�t>�� �w�w�t�A $͏Stamp Last Access Time ���'�C ͏Stamp Create Time ���'�M ͏Stamp Modify Time ���'�T  ú	�T

Returning to system ...
 �{��x�*`ݮ �w �tx�*`8	ݶ�w�t/ݦ�!� F#͚��*�*�+�_�C�%�R �R/O Sustain    =  ���F �Fast Relog     =  ���! �Change Warning =  ���P �Public Files   =  ���W �Pub/Path Write =  ���S �Path w/o SYS   =  @���>ʖͩ�B:j!i�*`ݦ ��w ��Wheel Protect  =  ���b(��- �:  �Z�[d(�x�b(��+�*`�r��s�ͩ�B�*	|�� �b�B�Z-System @  ��Search Path    =  ���b��- �:�*`�� ��B�I �^�V	�Internal
 �Z�[b(�x�b��+�*`�r��s��� ��p�*	|�� �b�B�Z-System @  �����Clock Routine  =  ��b��2�*`�s�r>�� �w�w�����2h�� +> �:h�A �Stamp Access   =  8�C �Stamp Create   =  �M $�Stamp Modify   =  ���*`�s��B���-y 	��:� ��Active
 �/�!j�w!iy�w���*`��~��_��-(͸ B{�_�Enabled
 ���-�[f �Disabled
 7��[ N�B�+�x�+�b����-- Invalid --
 ��  ��0�� ��� �+	~͸(  z��~���4͸�#��~��͸(#��ɷ�� ��,��	�#~�4����4�42m����0�:m�)�� ����0���
���
8�ɯ=�))))�o�(
�TYES ��TNO  ��p�T�~#� ����p �͇������*`ݦ�[f��R( �TEnabled â�[f��R(�~â�TDisabled âͬ͇ô�>H�)���O�T Routine [(D)isable), (S)et] :  ���D*f7��S �͏Enter Address of Routine :  !  ���T Routine [(D)isable), (E)nable] :  ���D7��E ���T
*** ERROR: DOS is not ZSDOS!
 ���͔����\���~#�?���(�(�(�(�$�0��ͬ�ʹ�͢�����͔���V#^#���������:�*������[����[�����*�:��W~�(͑������*������[��(��:�͢�������(����%-���%(�\ �)��4�D(L�2(C�3(;�.(+�+(*�>(�R(�I(�N ү�$,�}lg��0�g�|��)e�| |d�w
�w�0��/�0��Gz�0 �A(�)x��~�(#�\ ~#�)�z�����O*�|�(�+ �~�(G���� ����������� �����"�|�(� "��|�(D~�!8?� ~2�#~2�#~2� � ���_��:�O	���_� �������Y!�6 #�s#r#�6 #s#r#�6 #�� �����s#r#�~#���\ �#���( *�|����*�|�(~���"��|�� >Z�� ����(* >�O>��G>Z��  �������� ��|�� ���������! ~��#~��3ENV��� �ѷ��>�)>
�)���>�?����|�}�����Q�)���U�)������O>�?�����a��{��_����G����o��* o���Ɛ'�@'�                                  