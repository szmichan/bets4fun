using System;
using System.IO;
using System.Security.Cryptography;

namespace Bets4Fun.Common
{
    public static class PasswordEncoder
    {
        private const string Pass = "z@kl@dy";

        private static readonly byte[] Salt = {
            0x42, 0x76, 0x61, 0x6e, 0x20, 0x4a, 
            0x65, 0x63, 0x71, 0x65, 0x61, 0x65, 0x76
        };

        public static string EncodePasswordMd5(string password)
        {
            var md5 = new MD5CryptoServiceProvider();
            return Convert.ToBase64String(md5.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password)));
        }

        public static string EncryptStringRijndael(string inputString)
        {
            // Create a MemoryStream to accept the encrypted bytes 
            var ms = new MemoryStream();

            var clearBytes = System.Text.Encoding.Unicode.GetBytes(inputString);

            var pdb = new Rfc2898DeriveBytes(Pass, Salt);

            var alg = Rijndael.Create();
            alg.Key = pdb.GetBytes(32);
            alg.IV = pdb.GetBytes(16);

            var cs = new CryptoStream(ms, alg.CreateEncryptor(), CryptoStreamMode.Write);
            cs.Write(clearBytes, 0, clearBytes.Length);
            cs.Close();

            var encryptedData = ms.ToArray();

            return Convert.ToBase64String(encryptedData); 
        }

        public static string DecryptStringRijndael(string inputString)
        {
            var ms = new MemoryStream();

            var cipherBytes = Convert.FromBase64String(inputString); 

            var pdb = new Rfc2898DeriveBytes(Pass, Salt);

            var alg = Rijndael.Create();
            alg.Key = pdb.GetBytes(32);
            alg.IV = pdb.GetBytes(16);
            var cs = new CryptoStream(ms, alg.CreateDecryptor(), CryptoStreamMode.Write);
            cs.Write(cipherBytes, 0, cipherBytes.Length);
            cs.Close();

            var decryptedData = ms.ToArray();

            return System.Text.Encoding.Unicode.GetString(decryptedData);
        }
    }
}
