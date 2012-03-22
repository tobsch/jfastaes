package org.github.tobsch.jfastaes;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.jruby.Ruby;
import org.jruby.RubyClass;
import org.jruby.runtime.ObjectAllocator;
import org.jruby.runtime.builtin.IRubyObject;
import org.jruby.runtime.load.Library;

import org.jruby.Ruby;
import org.jruby.RubyClass;
import org.jruby.RubyString;
import org.jruby.util.ByteList;

import org.jruby.RubyObject;
import org.jruby.anno.JRubyMethod;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;


public class JFastAESLibrary implements Library {
  private Ruby ruby;

  public void load(Ruby ruby, boolean bln) {
    this.ruby = ruby;
    
    // define the jfastaes class
    final RubyClass jfastaes = ruby.defineClass("JFastAES", ruby.getObject(), new ObjectAllocator() {
      public IRubyObject allocate(Ruby ruby, RubyClass rc) {
        return new JFastAES(ruby, rc);
      }
      });

      jfastaes.defineAnnotatedMethods(JFastAES.class);
    
    }
  
    /**
      * A simple text cipher to encrypt/decrypt a string.
        */
    public class JFastAES  extends RubyObject {
      private byte[] linebreak = {}; // Remove Base64 encoder default linebreak
      private Cipher cipher;
      private SecretKey key;

      public JFastAES(final Ruby ruby, RubyClass rubyClass) {
        super(ruby, rubyClass);
      }

      @JRubyMethod
      public IRubyObject initialize(ThreadContext context,IRubyObject secret) throws Exception {
        key = new SecretKeySpec(secret.toString().getBytes(), "AES");
        cipher = Cipher.getInstance("AES/ECB/PKCS5Padding", "SunJCE");
      
        return context.nil;
      }
      
      @JRubyMethod
      public synchronized IRubyObject encrypt(ThreadContext context, IRubyObject plainText) throws Exception {
        cipher.init(Cipher.ENCRYPT_MODE, key);
        
        byte[] cipherText = cipher.doFinal(plainText.toString().getBytes());
        
        return context.runtime.newString(new ByteList(cipherText, true));
      }

      @JRubyMethod
      public synchronized IRubyObject decrypt(ThreadContext context, IRubyObject codedText) throws Exception {
        byte[] encypted = ((RubyString)codedText).getBytes();
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] decrypted = cipher.doFinal(encypted);  
        String stringVal = new String(decrypted);

        return context.runtime.newString(stringVal);
      }

      @JRubyMethod
      public synchronized IRubyObject encrypt64(ThreadContext context, IRubyObject plainText) throws Exception {
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] cipherText = cipher.doFinal(plainText.toString().getBytes());
        byte[] encoded = Base64.encodeBase64(cipherText, false);
        String stringVal = new String(encoded);
        return context.runtime.newString();
      }

      @JRubyMethod
      public synchronized IRubyObject decrypt64(ThreadContext context, IRubyObject codedText) throws Exception {
        byte[] encypted = Base64.decodeBase64(codedText.toString().getBytes());
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] decrypted = cipher.doFinal(encypted);  
        String stringVal = new String(decrypted);

        return context.runtime.newString(stringVal);
      }
    }
  }


