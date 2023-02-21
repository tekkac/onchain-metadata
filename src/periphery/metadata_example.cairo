// SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.cairo.common.uint256 import Uint256

from cairopen.string.ASCII import StringCodec
from cairopen.string.string import String
from cairopen.string.utils import StringUtil

from erc3525.IERC3525Full import IERC3525Full as IERC3525

namespace ERC3525MetadataDescriptor {
    func constructContractURI{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }() -> (uri_len: felt, uri: felt*) {
        alloc_locals;

        let (local tmp_name) = IERC3525.name(instance);
        let (local desc_str) = _contractDescription{instance=instance}();
        let (local img_str) = _contractImage{instance=instance}();
        let (decimals) = IERC3525.valueDecimals(instance);
        let (local decimals_str) = StringCodec.felt_to_string(decimals);

        let (str) = StringCodec.ss_to_string('{"name":"');
        let (str) = append_ss(str, tmp_name);
        let (str) = append_ss(str, '","description":');
        let (str) = StringUtil.concat(str, desc_str);
        let (str) = append_ss(str, ',"image":');
        let (str) = StringUtil.concat(str, img_str);
        let (str) = append_ss(str, ',"valueDecimals":');
        let (str) = StringUtil.concat(str, decimals_str);
        let (str) = append_ss(str, '}');

        return (str.len, str.data);
    }

    func constructSlotURI{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(slot: Uint256) -> (uri_len: felt, uri: felt*) {
        alloc_locals;
        let (local name_str) = _slotName{instance=instance}(slot);
        let (local desc_str) = _slotDescription{instance=instance}(slot);
        let (local img_str) = _slotImage{instance=instance}(slot);
        let (local props_str) = _slotProperties{instance=instance}(slot);

        let (str) = StringCodec.ss_to_string('{"name":');
        let (str) = StringUtil.concat(str, name_str);
        let (str) = append_ss(str, ',"description":');
        let (str) = StringUtil.concat(str, desc_str);
        let (str) = append_ss(str, ',"image":');
        let (str) = StringUtil.concat(str, img_str);
        let (str) = append_ss(str, ',"attributes":');
        let (str) = StringUtil.concat(str, props_str);
        let (str) = append_ss(str, '}');

        return (str.len, str.data);
    }

    func constructTokenURI{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(tokenId: Uint256) -> (uri_len: felt, uri: felt*) {
        alloc_locals;

        let (local name_str) = _tokenName{instance=instance}(tokenId);
        let (local desc_str) = _tokenDescription{instance=instance}(tokenId);
        let (local img_str) = _tokenImage{instance=instance}(tokenId);
        let (local props_str) = _tokenProperties{instance=instance}(tokenId);

        let (slot) = IERC3525.slotOf(instance, tokenId);
        let (local slot_str) = StringCodec.felt_to_string(slot.low);

        let (value) = IERC3525.valueOf(instance, tokenId);
        let (local value_str) = StringCodec.felt_to_string(value.low);

        let (str) = StringCodec.ss_to_string('data:application/json,');
        let (str) = append_ss(str, '{"name":');
        let (str) = StringUtil.concat(str, name_str);
        let (str) = append_ss(str, ',"description":');
        let (str) = StringUtil.concat(str, desc_str);
        let (str) = append_ss(str, ',"image_data":"');
        let (str) = StringUtil.concat(str, img_str);
        let (str) = append_ss(str, '","slot":');
        let (str) = StringUtil.concat(str, slot_str);
        let (str) = append_ss(str, ',"value":');
        let (str) = StringUtil.concat(str, value_str);
        let (str) = append_ss(str, ',"properties":');
        let (str) = StringUtil.concat(str, props_str);
        let (str) = append_ss(str, '}');

        return (str.len, str.data);
    }

    func _contractDescription{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }() -> (uri: String) {
        let (str) = StringCodec.ss_to_string('"dummy description"');
        return (uri=str);
    }

    func _contractImage{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }() -> (uri: String) {
        let (str) = StringCodec.ss_to_string('"dummy image"');
        return (uri=str);
    }

    func _slotName{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(slot: Uint256) -> (uri: String) {
        let (str) = StringCodec.ss_to_string('"dummy slot name"');
        return (uri=str);
    }

    func _slotDescription{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(slot: Uint256) -> (uri: String) {
        let (str) = StringCodec.ss_to_string('"dummy slot description"');
        return (uri=str);
    }

    func _slotImage{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(slot: Uint256) -> (uri: String) {
        let (str) = StringCodec.ss_to_string('"dummy slot image"');
        return (uri=str);
    }

    func _slotProperties{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(slot: Uint256) -> (uri: String) {
        let (str) = StringCodec.ss_to_string('[]');
        return (uri=str);
    }

    func _tokenName{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(tokenId: Uint256) -> (uri: String) {
        alloc_locals;
        let (symbol) = IERC3525.symbol(instance);
        let (str) = StringCodec.ss_to_string('"');
        let (str) = append_ss(str, symbol);
        let (str) = append_ss(str, ' #');
        let (id_str) = StringCodec.felt_to_string(tokenId.low + tokenId.high * 2 ** 128);
        let (str) = StringUtil.concat(str, id_str);
        let (str) = append_ss(str, '"');

        return (uri=str);
    }

    func _tokenDescription{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(tokenId: Uint256) -> (uri: String) {
        let (str) = StringCodec.ss_to_string('"dummy token description"');
        return (uri=str);
    }

    func setTokenImage{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
    }(uri_len: felt, uri: felt*) {
        alloc_locals;
        let (str) = StringCodec.ss_arr_to_string(uri_len, uri);
        StringCodec.write('token_uri', str);
        return ();
    }

    func _tokenImage{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(tokenId: Uint256) -> (uri: String) {
        // let (str) = StringCodec.read('token_uri');
        alloc_locals;
        let (value) = IERC3525.valueOf(instance, tokenId);
        let (local value_str) = StringCodec.felt_to_string(value.low);

        let (str) = StringCodec.ss_to_string('data:image/svg+xml,<?xml versio');
        let (str) = append_ss(str, 'n=\"1.0\" encoding=\"UTF-8\" ?>');
        let (str) = append_ss(str, '<svg width=\"300\" height=\"300');
        let (str) = append_ss(str, '\" xmlns=\"http://www.w3.org/20');
        let (str) = append_ss(str, '00/svg\"><image href=\"https://');
        let (str) = append_ss(str, 'bafybeibbweymszo4mjlkvxdoyieeq4');
        let (str) = append_ss(str, 'svl4k2orovwi5nyybjwqvmfqdczy.ip');
        let (str) = append_ss(str, 'fs.dweb.link/002.jpg\" width=\"');
        let (str) = append_ss(str, '100%\" height=\"100%\"/><rect x');
        let (str) = append_ss(str, '=\"15\" y=\"20\" width=\"110\" ');
        let (str) = append_ss(str, 'height=\"25\" rx=\"5\" ry=\"5\"');
        let (str) = append_ss(str, ' stroke=\"black\" fill=\"yellow');
        let (str) = append_ss(str, '\" stroke-width=\"2\" fill-opac');
        let (str) = append_ss(str, 'ity=\"0.8\"/><text x=\"20\" y=\');
        let (str) = append_ss(str, '"37\"><tspan fill=\"blue\" font');
        let (str) = append_ss(str, '-weight=\"bold\">Value</tspan><');
        let (str) = append_ss(str, 'tspan dx=\"10\" fill=\"darkblue');
        let (str) = append_ss(str, '\">');
        let (str) = StringUtil.concat(str, value_str);
        let (str) = append_ss(str, ' sq.m</tspan></text></svg>');

        return (uri=str);
    }

    func _tokenProperties{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        bitwise_ptr: BitwiseBuiltin*,
        range_check_ptr,
        instance,
    }(tokenId: Uint256) -> (String,) {
        alloc_locals;
        let (value) = IERC3525.valueOf(instance, tokenId);
        let (local value_str) = StringCodec.felt_to_string(value.low);
        let (str) = StringCodec.ss_to_string('[{"trait_type":"Token Value",');
        let (str) = append_ss(str, '"value":');
        let (str) = StringUtil.concat(str, value_str);
        let (str) = append_ss(str, '}]');
        return (uri=str);
    }
}

func append_ss{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(str: String, s: felt) -> (
    str: String
) {
    alloc_locals;
    let (tmp_str) = StringCodec.ss_to_string(s);
    let (res) = StringUtil.concat(str, tmp_str);
    return (str=res);
}
