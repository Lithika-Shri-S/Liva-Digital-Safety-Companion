# 🔧 Complete Diagnostic & Testing Guide - Find the Root Issues

## 🚨 **CRITICAL FIRST STEP: Test the Basics**

Before testing real messaging apps, we need to verify that the core systems work. I've added powerful diagnostic tools to isolate the problems.

### **📱 Step 1: Install Updated App**
```bash
# Build and install the enhanced debug version
./gradlew assembleDebug
adb install -r app/build/outputs/apk/debug/app-debug.apk

# Clear old data for fresh start
adb shell pm clear com.liva.liva
```

### **🧪 Step 2: Test Core Functionality (MANUAL TESTS)**

Open the app and go to **Debug Console**. You'll now see new **🔥 MANUAL** test buttons:

#### **Test 1: Direct Notification Test**
1. Tap **"🔥 DIRECT Test Notification"**
2. **Expected**: Notification should appear immediately
3. **If it fails**: Notification permissions are the problem

#### **Test 2: Manual Liva Response Test**
1. Tap **"🔥 MANUAL Test Liva Response"**
2. **Expected**: "Digital Safety Companion Active!" notification
3. **If it fails**: Message processing pipeline has issues

#### **Test 3: Manual Friend Message Test**
1. Tap **"🔥 MANUAL Test Friend Message"**  
2. Go to Safety Risk Log
3. **Expected**: Should show the friend message stored
4. **If it fails**: Database storage is broken

#### **Test 4: Manual Critical Threat Test**
1. Tap **"🔥 MANUAL Test Critical Threat"**
2. **Expected**: Critical threat notification + database storage
3. **If it fails**: High-risk notification system broken

## 🔍 **Step 3: Accessibility Service Debugging**

If manual tests work but real messages don't, the accessibility service isn't capturing messages.

### **Check Service Status:**
```bash
# See if accessibility service is running
adb shell dumpsys accessibility | findstr "liva"

# Should show something like:
# Service: com.liva.liva/.service.MessageMonitoringService
```

### **Monitor Real-Time Events:**
```bash
# Watch for accessibility events in real-time
adb logcat | findstr "MessageMonitoringService\|🔥\|📱\|📢\|📝"
```

### **Test Real Message Detection:**
1. Open WhatsApp/Discord/SMS
2. Send yourself a message containing "test"
3. **Expected Console Output:**
   ```
   🔥 ACCESSIBILITY EVENT DETECTED from WhatsApp!
   📱 Accessibility event: NOTIFICATION_STATE_CHANGED from com.whatsapp
   📢 Handling notification event from com.whatsapp
   📧 Extracting message from notification...
   ```

4. **If you see NOTHING**: Accessibility service is not enabled or not working
5. **If you see events but no message extraction**: Message parsing is broken

## 🛠️ **Step 4: Progressive Troubleshooting**

### **Problem A: No Manual Tests Work**
- **Issue**: Core app functionality is broken
- **Solutions**: 
  - Check notification permissions in Android Settings
  - Verify app isn't in battery optimization
  - Clear app cache and restart

### **Problem B: Manual Tests Work, No Real Messages**
- **Issue**: Accessibility service not capturing events
- **Solutions**:
  1. **Enable Accessibility Service:**
     - Android Settings → Accessibility
     - Find "Liva" → Turn ON
     - Grant all permissions
  
  2. **Restart Service:**
     - Disable accessibility service
     - Re-enable it
     - Reboot device if needed

### **Problem C: Events Detected, No Message Extraction**
- **Issue**: Message parsing from notifications/content is failing
- **Debug Output**: You see event logs but "❌ Failed to extract message"
- **Solution**: The message extraction logic needs app-specific tuning

### **Problem D: Messages Extracted, No Database Storage**
- **Issue**: Database operations failing
- **Debug Output**: You see message extraction but no "✅ Unique threat record saved"
- **Solution**: Database permissions or threading issues

## 📊 **Step 5: Real-Time Debugging Commands**

### **Monitor All App Activity:**
```bash
# Complete real-time monitoring
adb logcat | findstr "liva\|Liva\|🔥\|✅\|❌\|📱\|🤖\|🚨"
```

### **Focus on Accessibility Events:**
```bash
# Watch only accessibility service
adb logcat | findstr "MessageMonitoringService"
```

### **Focus on Message Processing:**
```bash
# Watch message processing pipeline
adb logcat | findstr "MessageProcessor\|processIncomingMessage"
```

### **Focus on Notifications:**
```bash
# Watch notification system
adb logcat | findstr "NotificationHelper\|notification"
```

## 🎯 **Expected Working Flow**

When everything works correctly, here's what you should see:

### **Manual Test (should always work):**
```
🤖 MANUALLY Testing Liva response...
🔍 Checking if 'liva can you see me?' from 'Manual Test User' is a test message...
🤖 Test message detected! Triggering Liva response notification...
⚡ Processing test message: 'liva can you see me?' from 'Manual Test User'
📡 Sending Liva response notification...
✅ Liva response notification sent successfully!
```

### **Real WhatsApp Message (when fixed):**
```
🔥 ACCESSIBILITY EVENT DETECTED from WhatsApp!
📱 Accessibility event: NOTIFICATION_STATE_CHANGED from com.whatsapp
📢 Handling notification event from com.whatsapp
📧 Extracting message from notification...
✅ Message detected from notification: liva can you see me?
📢 NOTIFICATION MESSAGE: 'liva can you see me?' from 'Friend Name'
🔄 Processing incoming message: 'liva can you see me?' from 'Friend Name' via WhatsApp
🔍 Checking if 'liva can you see me?' from 'Friend Name' is a test message...
🤖 Test message detected! Triggering Liva response notification...
```

## 🧩 **Step 6: Specific Tests for Your Issues**

### **Test "Liva" Response:**
1. **Manual first**: Use "🔥 MANUAL Test Liva Response" button
2. **If manual works**: Test real "liva can you see me?" in WhatsApp
3. **Watch console**: Should see test message detection and notification

### **Test Friend Message Storage:**
1. **Manual first**: Use "🔥 MANUAL Test Friend Message" button  
2. **Check Safety Risk Log**: Should show stored message
3. **If manual works**: Test real friend message with negative content

### **Test Critical Threats:**
1. **Manual first**: Use "🔥 MANUAL Test Critical Threat" button
2. **Should get notification**: Critical threat alert
3. **Check Safety Risk Log**: Should show threat record

## 📋 **Diagnostic Checklist**

Run through these in order:

- [ ] **App installs and opens**
- [ ] **Direct notification test works** (🔥 DIRECT Test Notification)
- [ ] **Manual Liva response works** (🔥 MANUAL Test Liva Response)  
- [ ] **Manual friend message stores in database** (check Safety Risk Log)
- [ ] **Manual critical threat sends notification** (🔥 MANUAL Test Critical Threat)
- [ ] **Accessibility service appears in Android Settings**
- [ ] **Accessibility service is enabled and running**
- [ ] **Real message events appear in console** (adb logcat)
- [ ] **Real message extraction works** (see extracted content in logs)
- [ ] **Real messages processed through pipeline** (see processing logs)

## 🚀 **Next Steps Based on Results**

### **If ALL manual tests work:**
- Problem is ONLY with accessibility service
- Focus on enabling and debugging the accessibility service

### **If notifications don't work (even manual):**
- Problem is with notification permissions/system
- Check Android Settings → Apps → Liva → Notifications

### **If database doesn't work (even manual):**
- Problem is with app permissions or database setup
- Try clearing app data and re-granting permissions

---

**The manual tests will help us identify EXACTLY where the problem is. Run these tests first and let me know the results - this will tell us whether the issue is with the accessibility service, notification system, database, or core message processing.**