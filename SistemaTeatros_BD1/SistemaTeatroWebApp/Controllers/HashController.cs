using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace SistemaTeatroWebApp.Controllers
{
    public class HashController : Controller
    {
        public static string ComputeHash(string plainText, byte[] salt)
        {
            int minSaltLength = 4;
            int maxSaltLength = 16;

            byte[] SaltBytes = null;

            if (salt != null)
            {
                SaltBytes = salt;
            }
            else
            {
                Random r = new Random();
                int SaltLength = r.Next(minSaltLength, maxSaltLength);
                SaltBytes = new byte[SaltLength];

                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                rng.GetNonZeroBytes(SaltBytes);
                rng.Dispose();
            }

            byte[] plainData = ASCIIEncoding.UTF8.GetBytes(plainText);
            byte[] plainDataAndSalt = new byte[plainData.Length + SaltBytes.Length];

            for (int i = 0; i < plainData.Length; i++)
            {
                plainDataAndSalt[i] = plainData[i];
            }
            for (int j = 0; j < SaltBytes.Length; j++)
            {
                plainDataAndSalt[plainData.Length + j] = SaltBytes[j];
            }

            byte[] hashValue = null;
            SHA256Managed sha = new SHA256Managed();
            hashValue = sha.ComputeHash(plainDataAndSalt);
            sha.Dispose();

            byte[] result = new byte[hashValue.Length + SaltBytes.Length];

            for (int i = 0; i < hashValue.Length; i++)
            {
                result[i] = hashValue[i];
            }

            for (int i = 0; i < SaltBytes.Length; i++)
            {
                result[hashValue.Length + i] = SaltBytes[i];
            }

            return Convert.ToBase64String(result);
        }

        public static bool ConfirmPassword(string plainText, string hashValue)
        {
            byte[] hashBytes = Convert.FromBase64String(hashValue);
            int hashSize = 32;

            byte[] saltBytes = new byte[hashBytes.Length - hashSize];

            for (int i = 0; i < saltBytes.Length; i++)
            {
                saltBytes[i] = hashBytes[hashSize + i];
            }
            string NewHash = ComputeHash(plainText, saltBytes);

            return (hashValue == NewHash);
        }
    }
}