package com.safaricom.SampleApi.Operation;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "api/operations")
public class OperationsController {

	@GetMapping("/add")
	public int add(@RequestParam(name = "name", required = true) int a,
			@RequestParam(name = "name", required = true) int b) {
		return a + b;
	}

	@GetMapping("/subtract")
	public int subtract(@RequestParam(name = "name", required = true) int a,
			@RequestParam(name = "name", required = true) int b) {
		return a - b;
	}

	@GetMapping("/multiply")
	public int multiply(@RequestParam(name = "name", required = true) int a,
			@RequestParam(name = "name", required = true) int b) {
		return a * b;
	}

	@GetMapping("/divide")
	public int divide(@RequestParam(name = "name", required = true) int a,
			@RequestParam(name = "name", required = true) int b) {
		if (b == 0) {
			return 0;
		}
		return a * b;
	}
}
